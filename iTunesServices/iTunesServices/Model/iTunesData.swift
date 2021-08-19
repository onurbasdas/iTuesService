//
//  iTunesData.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import Foundation

struct FeedTest: Codable {
    let feed : iTunesData
}

struct iTunesData : Codable {
    var title : String?
    var copyright : String?
    var country :String?
    var results : [Results]?
}

struct Results: Codable {
    var artistName : String?
    var id : String?
    var releaseDate : String?
    var name : String?
    var kind : String?
    var artistId : String?
    var artistUrl : String?
    var artworkUrl100 : String?
}
