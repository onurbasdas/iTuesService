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
    var results : [MovieDetail]?
}
