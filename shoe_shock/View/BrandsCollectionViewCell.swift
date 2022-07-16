//
//  BrandsCollectionViewCell.swift
//  shoe_shock
//
//  Created by adrian garcia on 5/17/22.
//

import UIKit

protocol BrandsCollectionViewCellDelegate: AnyObject {
    func getShoes(brandindex: Int)
}

class BrandsCollectionViewCell: UICollectionViewCell {
 
    static let cellReuseID = "brandscell"
    weak var brandsDelegate: BrandsCollectionViewCellDelegate?

    @IBOutlet weak var brandButton: UIButton!
    
    var brandIndexTracker = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateViews(brandIndexTracker: Int, delgate: BrandsCollectionViewCellDelegate) {
        brandButton.setTitle(Api.instance.getBrands()[brandIndexTracker].title, for: .normal)
        self.brandIndexTracker = brandIndexTracker
        brandsDelegate = delgate
    }
    
    @IBAction func BrandbuttonPressed(_ sender: UIButton) {
        brandsDelegate?.getShoes(brandindex: brandIndexTracker)
        
    }
    
}
 
