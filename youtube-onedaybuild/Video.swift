//
//  Video.swift
//  youtube-onedaybuild
//
//  Created by Anh Dinh on 11/24/20.
//

import Foundation

struct Video: Decodable {
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum CodingKeys: String, CodingKey{
        // these variable names match the ones on JSON
        case snippet
        case thumbnails
        case high
        case resourceId
        
        // the right side is the key from JSON,
        // if the key match the variables we created AND the one on JSON, we don't have to specify it
        // see "published" is the one we created but on JSON it's "publishedAt" so we have to make published = publishedAt
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
    }
    
    // JSON will be passed to init to map data the way we want
    init(from decoder: Decoder) throws {
        
        // we get the container from the "item" and store it to  variable "container"
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // this looks for "snippet" container from JSON
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parse title from "snippet" container
        self.title = try snippetContainer.decode(String.self, forKey:.title)
        
        // Parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // Parse publish date
        self.published = try snippetContainer.decode(Date.self,forKey: .published)
        
        // get "thumbnails" container
        let thumnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        // get the "high" container
        let highContainer = try thumnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey:.videoId)
    }
    
}
