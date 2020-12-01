//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by Anh Dinh on 11/24/20.
//

import Foundation

protocol ModelDelegate {
    func videosFetched(_ videos: [Video])
}

class Model{
    
    var delegate:ModelDelegate?
    
    func getVideos(){
        // create URL object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        
        // get a URLSession object
        let session = URLSession.shared
        
        // Get a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil || data == nil{
                print("There's an error during networking")
            }
            
            if data != nil{
                print("Data Requested")
            }
            
            do{
                // Parsing data inton video objects
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                // response is an instance/object of Response struct
                let response = try decoder.decode(Response.self, from: data!)
                 
                if response != nil {
                    // call the "videoFetched" methods of the delegate
                    // response.items is an array of Video struct
                    self.delegate?.videosFetched(response.items!)
                }
 
                //dump(response)
            }catch{
                print(error)
            }
            
            
            
        }
        
        // Kick off the task
        dataTask.resume()
        
    }
    
}
