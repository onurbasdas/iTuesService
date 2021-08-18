//
//  Service.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import Foundation
import Alamofire

class Service {
    func getInfo(callback:@escaping (iTunesData?) -> Void){
        AF.request("\(Constants.baseUrl)", method: .get,encoding: JSONEncoding.default).response{ response in
            guard let data = response.data else {return}
            do {
                let movieResponse = try JSONDecoder().decode(FeedTest.self, from:data)
                let movie = movieResponse.feed
                callback(movie)
            }catch let e {
                print(e)
            }
        }
    }
}
