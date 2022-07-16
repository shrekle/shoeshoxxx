//
//  ShoeCollectionViewCell.swift
//  shoe_shock
//
//  Created by adrian garcia on 5/17/22.
//

import UIKit

protocol ShoeCollectionViewCellDelegate: AnyObject {
    func getSpecificShoe(shoe: Shoe)
}

class ShoeCollectionViewCell: UICollectionViewCell {
    
    weak var shoeDelegate: ShoeCollectionViewCellDelegate?
    
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var shoeModelLbl: UILabel!
    @IBOutlet weak var shoeImg: UIImageView!
    @IBOutlet weak var heartButtonLabel: UIButton!
    
//    var isShoeHearted = false
    var BrandTitle = String()
    var shoeArray = [Shoe]()
    var brandIndexTracker = 0
    var indexPath = 0
    var specificShoe = Shoe(brand: "erf", model: "sd", price: "wdsfv", imageName: "sdf", isHearted: nil, counter: 0)
    var cartArray = [String]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateViews(brandIndexTracker: Int, indexPath: Int, specificShoe: Shoe, delegate: ShoeCollectionViewCellDelegate) {
        self.indexPath = indexPath
        self.brandIndexTracker = brandIndexTracker
        BrandTitle = Api.instance.getBrands()[brandIndexTracker].title
        shoeArray = Api.instance.brandChoosen(title: BrandTitle)
//        self.specificShoe = Api.instance.getShoes(brand: Api.instance.getBrands()[brandIndexTracker])[indexPath]
        self.specificShoe = specificShoe
        brandLbl.text = BrandTitle
        shoeModelLbl.text = shoeArray[indexPath].model
        shoeImg.image = UIImage(named: shoeArray[indexPath].imageName)
        shoeDelegate = delegate
    }
    
//    i need to isolate the brand and model that in the cell that the heart was clicked
//    how do i tap into the specific Shoe to tap into the bool property?
//    separate funcs, one that scans the brand and shoe title, .map, and one that adds the brand and title to the array
//    with a toggle on add to the array and toggle of run the remove func that scans with .map
    
//    func addToCartArray() {
//        guard let specificShoe = specificShoe else {return}
//        if specificShoe.isHearted == true {
//            cartArray.append(specificShoe.model)
//
//        }
//    }
    func heartState(sender: UIButton) {
//        guard var specificShoe = specificShoe else {return print("not working")}
        if specificShoe.isHearted == nil {
            specificShoe.isHearted = true
                    sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            specificShoe.counter += 1
            print("changed to true",specificShoe.counter)
        }
       else if specificShoe.isHearted == true {
            specificShoe.isHearted = false
                    sender.setImage(UIImage(systemName: "heart"), for: .normal)
           specificShoe.counter -= 1
           
           print("changed to false", specificShoe.counter)
            
                }
        else if specificShoe.isHearted == false {
             specificShoe.isHearted = true
                     sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            specificShoe.counter += 1
            print("changed to true again",specificShoe.counter)
             
                 }
    }
//    func heartState(sender: UIButton) {
//        if isShoeHearted == false {
//            isShoeHearted = true
//            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            sender.titleLabel?.text = shoesForCell[shoeIndex].model
//        } else if isShoeHearted == true {
//            isShoeHearted = false
//            sender.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
//    }
    @IBAction func heartButton(_ sender: UIButton) {
        heartState(sender: sender)
        shoeDelegate?.getSpecificShoe(shoe: specificShoe)
    }
}
