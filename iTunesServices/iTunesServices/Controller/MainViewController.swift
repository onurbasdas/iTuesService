//
//  MainViewController.swift
//  iTunesServices
//
//  Created by Onur Başdaş on 18.08.2021.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    @IBOutlet var mainCollectionView: UICollectionView!
    
    var service = Service()
    var resultData = [Results]()
    var iTunes = iTunesData()
    var detailsInfo : Results = Results()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.register(MainCollectionViewCell.nib(), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        getData()
    }
    
    func getData() {
        service.getInfo { result in
            DispatchQueue.main.async { [self] in
                self.iTunes = result!
                resultData.append(contentsOf: iTunes.results!)
                mainCollectionView.reloadData()
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.labelMain.text = resultData[indexPath.item].name
        cell.imageMain.kf.setImage(with: URL(string: resultData[indexPath.item].artworkUrl100!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detailsInfo = resultData[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailViewController {
            dest.selectedItemModel = detailsInfo
        }
    }
}
