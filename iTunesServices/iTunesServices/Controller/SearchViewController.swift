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
    var searchTunes = iTunesData()
    var searchInfo : BookDetail = BookDetail()
    var str = [BookDetail]()
    
    
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchInfo = searchData[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailViewController {
            dest.selectedItemModel = searchInfo
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = UIColor.black
        textFieldInsideUISearchBar?.font = textFieldInsideUISearchBar?.font?.withSize(16)
        let labelInsideUISearchBar = textFieldInsideUISearchBar!.value(forKey: "placeholderLabel") as? UILabel
        labelInsideUISearchBar?.textColor = UIColor.black
        labelInsideUISearchBar?.font = labelInsideUISearchBar?.font?.withSize(16)
        print(searchText)
        
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        for index in searchData {
            if index.name == searchBar.text {
                str.append(index)
            }
        }
        searchData.removeAll()
        searchData = str
        searchTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchData.removeAll()
        str.removeAll()
        getData()
        searchTableView.reloadData()
    }
}
