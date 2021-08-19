//
//  SearchViewController.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {

    @IBOutlet var searchButton: UISearchBar!
    @IBOutlet var searchTableView: UITableView!
    
    var searchData = [MovieDetail]()
    var searchTunes = iTunesData()
    var service = Service()
    var searchInfo : MovieDetail = MovieDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
        getData()
    }
    
    func getData() {
        service.getInfo { result in
            DispatchQueue.main.async { [self] in
                self.searchTunes = result!
                searchData.append(contentsOf: searchTunes.results!)
                searchTableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.imageName.text = searchData[indexPath.row].name
        cell.imageAuthor.text = searchData[indexPath.row].artistName
        cell.imageDate.text = searchData[indexPath.row].releaseDate
        cell.imageSearch.kf.setImage(with: URL(string: searchData[indexPath.row].artworkUrl100!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
