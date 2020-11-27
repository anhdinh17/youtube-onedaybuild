//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by Anh Dinh on 11/24/20.
//

import Foundation


class Model {
    
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
                
                let response = try decoder.decode(Response.self, from: data!)
                
                dump(response)
            }catch{
                print(error)
            }
            
            
            
        }
        
        // Kick off the task
        dataTask.resume()
        
    }
    
}
