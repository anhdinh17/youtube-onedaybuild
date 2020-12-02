//
//  DetailViewController.swift
//  youtube-onedaybuild
//
//  Created by Anh Dinh on 12/2/20.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var webView: WKWebView!
    
    
    @IBOutlet weak var textView: UITextView!
    
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    // this one happens after viewDidLoad, when things will appear on screen
    override func viewWillAppear(_ animated: Bool) {
        // clear the view from previous play
        titleLabel.text = ""
        dateLabel.text = ""
        textView.text = ""
        
        // check if there's a vieo
        guard  video != nil else {
            return
        }
        
        // create embed url
        let embedUrlString = Constants.YT_EMBED_URL + video!.videoId
        // load it into webview
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        // set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = df.string(from: video!.published)
        
        // set the description
        textView.text = video!.description
    }
    
}
