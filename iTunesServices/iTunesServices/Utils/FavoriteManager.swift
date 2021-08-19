//
//  FavoriteManager.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 19.08.2021.
//

import Foundation

class FavoriteManager {
    
    static func readFavoriteKey() -> String {
        return String(format: "favoriteFilms%@")
    }
    
    static func readFavoriteMovies() -> [BookDetail] {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: readFavoriteKey()) as? NSData {
            let movieList = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [BookDetail]
            return movieList
        }
        return [BookDetail]()
    }
    
    static func saveFavoriteFilm(film: BookDetail) {
        var currentList = readFavoriteMovies()
        currentList.append(film)
        let defaults = UserDefaults.standard
        let data = NSKeyedArchiver.archivedData(withRootObject: currentList)
        defaults.set(data, forKey: readFavoriteKey())
        defaults.synchronize()
    }
    
    static func deleteMovie(movieId: String) {
        if checkIfFavorites(movieId: movieId) {
            var currentList = readFavoriteMovies()
            currentList.removeAll { (item) -> Bool in
                item.id == movieId
            }
            let defaults = UserDefaults.standard
            let data = NSKeyedArchiver.archivedData(withRootObject: currentList)
            defaults.set(data, forKey: readFavoriteKey())
            defaults.synchronize()
        }
    }
    
    static func checkIfFavorites(movieId: String) -> Bool {
        let movieList = readFavoriteMovies()
        return movieList.filter { (item) -> Bool in
            item.id == movieId
        }.count > 0
    }
}
