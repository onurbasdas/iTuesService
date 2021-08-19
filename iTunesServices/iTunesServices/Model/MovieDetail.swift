//
//  MovieDetail.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 19.08.2021.
//

import Foundation

class MovieDetail: NSObject, Codable, NSCoding {
    var artistName : String?
    var id : String?
    var releaseDate : String?
    var name : String?
    var kind : String?
    var artistId : String?
    var artistUrl : String?
    var artworkUrl100 : String?
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        
        self.artistName = aDecoder.decodeObject(forKey: "artistName") as? String
        self.id = aDecoder.decodeObject(forKey: "id") as? String
        self.releaseDate = aDecoder.decodeObject(forKey: "releaseDate") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.kind = aDecoder.decodeObject(forKey: "kind") as? String
        self.artistId = aDecoder.decodeObject(forKey: "artistId") as? String
        self.artistUrl = aDecoder.decodeObject(forKey: "artistUrl") as? String
        self.artworkUrl100 = aDecoder.decodeObject(forKey: "artworkUrl100") as? String
    }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(artistName!, forKey: "artistName")
        aCoder.encode(id!, forKey: "id")
        aCoder.encode(releaseDate, forKey: "releaseDate")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(kind, forKey: "kind")
        aCoder.encode(artistId!, forKey: "artistId")
        aCoder.encode(artistUrl!, forKey: "artistUrl")
        aCoder.encode(artworkUrl100, forKey: "artworkUrl100")
    }
}
