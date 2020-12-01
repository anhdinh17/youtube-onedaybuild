//
//  Response.swift
//  youtube-onedaybuild
//
//  Created by Anh Dinh on 11/27/20.
//

import Foundation

struct Response: Decodable {
    
    var items: [Video]?
    
    enum CodingKeys: String, CodingKey{
        case items
    }
    
    init(from decoder: Decoder) throws {
        // this container is the whole data from JSON
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // we get data for "items"
        // the type for "items" is array of object which is on JSON, that's why we used [Video]
        self.items = try container.decode([Video].self,forKey: .items)
    }
}
