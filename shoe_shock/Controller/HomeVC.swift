//
//  HomeVC2ViewController.swift
//  shoe_shock
//
//  Created by adrian garcia on 6/14/22.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var brandsCollectionView: UICollectionView! {
        didSet {
            brandsCollectionView.delegate = self
            brandsCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var shoeCollectionView: UICollectionView! {
        didSet {
            shoeCollectionView.delegate = self
            shoeCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var suggestionsCollectionView: UICollectionView! {
        didSet {
            suggestionsCollectionView.delegate = self
            suggestionsCollectionView.dataSource = self
        }
    }
    
    var brandIndexTracker = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
} 

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        getCellCount(CV: collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = getId(for: collectionView)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? BrandsCollectionViewCell {
            cell.updateViews(brandIndexTracker: indexPath.row, delgate: self)
            return cell
        }
        else if let cell = cell as? ShoeCollectionViewCell {
            var specificShoe = Api.instance.getShoes(brand: Api.instance.getBrands()[brandIndexTracker])[indexPath.row]
            cell.updateViews(brandIndexTracker: brandIndexTracker, indexPath: indexPath.row, specificShoe: specificShoe, delegate: self)
            
            return cell
        }
        else if let cell =  cell as? SuggestionsCollectionViewCell {
            cell.updateViews(index: indexPath.row)
            return cell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var specificShoe = Api.instance.getShoes(brand: Api.instance.getBrands()[brandIndexTracker])[indexPath.row]
gf
    }
}

extension HomeVC: BrandsCollectionViewCellDelegate, ShoeCollectionViewCellDelegate {
    
    func getShoes(brandindex: Int) {
        brandIndexTracker = brandindex
        shoeCollectionView.reloadData()
    }
    func getSpecificShoe(shoe: Shoe) {
        specificShoe = shoe
        
    }
}
private extension HomeVC {
    
    func getCellCount(CV: UICollectionView)-> Int {
        switch CV {
        case brandsCollectionView:
            return Api.instance.getBrands().count
        case shoeCollectionView:
            return Api.instance.getNike().count
        case suggestionsCollectionView:
            return Api.instance.getAllShoes().count
        default:
            return 0
        }
    }
    
    func getId(for collectionView: UICollectionView)-> String {
        
        switch collectionView {
        case brandsCollectionView:
            return BrandsCollectionViewCell.cellReuseID
        case shoeCollectionView:
            return "shoeCell"
        case suggestionsCollectionView:
            return "suggestionsCell"
        default:
            return "brandsCell"
        }
    }
}
