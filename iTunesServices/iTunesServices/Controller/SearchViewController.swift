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
    
    var service = Service()
    var searchData = [BookDetail]()
    var filteredSearchData = [BookDetail]()
    var searchTunes = iTunesData()
    var searchInfo : BookDetail = BookDetail()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
        searchButton.delegate = self
        getData()
        
    }
    
    func getData() {
        service.getInfo { result in
            DispatchQueue.main.async { [self] in
                self.searchTunes = result!
                searchData.append(contentsOf: searchTunes.results!)
                filteredSearchData.append(contentsOf: searchTunes.results!)
                searchTableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        cell.imageName.text = filteredSearchData[indexPath.row].name
        cell.imageAuthor.text = filteredSearchData[indexPath.row].artistName
        cell.imageDate.text = filteredSearchData[indexPath.row].releaseDate
        cell.imageSearch.kf.setImage(with: URL(string: filteredSearchData[indexPath.row].artworkUrl100!))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchInfo = filteredSearchData[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailViewController {
            dest.selectedItemModel = searchInfo
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate,UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredSearchData = searchData.filter({$0.name!.contains(searchText)})
        if searchText == "" {
            filteredSearchData = searchData
        }
        searchTableView.reloadData()
    }
}
