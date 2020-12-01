//
//  ViewController.swift
//  youtube-onedaybuild
//
//  Created by Anh Dinh on 11/23/20.
//

import UIKit

class ViewController: UIViewController, ModelDelegate{
   
    @IBOutlet weak var tableView: UITableView!
    
    var model = Model()
    var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // conform to Model Delegate
        model.delegate = self
        
        // conform Viewcontroller to Protocols
        tableView.dataSource = self
        tableView.delegate = self
        
        model.getVideos()
    }

    //MARK: - ModelDelegte Methods
    func videosFetched(_ videos: [Video]) {
       // set the returned videos to our video property
        self.videos = videos
        
        DispatchQueue.main.async {
            // Refresh the tableView
            self.tableView.reloadData()
        }
        
    }
    
}

//MARK: - TableView Methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        
        let video = self.videos[indexPath.row]
        
        cell.setCell(video)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
