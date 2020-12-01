//
//  VideoTableViewCell.swift
//  youtube-onedaybuild
//
//  Created by Anh Dinh on 11/30/20.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    // create a variable to store the Video object
    var video: Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(_ v: Video)
    {
        self.video = v
        
        // ensure we have video
        guard self.video != nil else{
            print("There's no video")
            return
        }
        
        // Set the title
        self.titleLabel.text = video?.title
        
        // Set the date to the form of "Tuesday, Dec 1, 2020"
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        // convert the date from video.published to String and display
        self.dateLabel.text = df.string(from: video!.published)
        
        // Set the thumbnail
        guard self.video?.thumbnail != nil else{
            return
        }
        
        // Check cache before downloading data
        if let cacheData = CacheManager.getVideoCache(self.video!.thumbnail){
            // Set the thumbnail imageview
            self.thumbnailImageView.image = UIImage(data: cacheData)
            return
        }
        
        // Process of downloading thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil{
                
                // Save the data in the cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                // Check that the downloaded url matches the video thumbnail url that this cell is currently set to display
                if url!.absoluteString != self.video?.thumbnail{
                    // Video cell has been recycled for another video and no longer matches the thumbnail that was downloaded.
                    return
                }
                
                // create image object
                let iamge = UIImage(data: data!)
                
                // Set the imageView
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = iamge
                }
            }
        }
        
        dataTask.resume()
        
    }
    
}
