//
//  ProductTableViewCell.swift
//  ProductsBarcodeScanner
//
//  Created by Nikos Menexis on 23/04/2019.
//  Copyright © 2019 Nikos Menexis. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productLogoImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productBarcodeLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    
    func setUpCell(product:Product){
        
        if let actuaImage = product.logoImage{
            self.productLogoImageView.image = actuaImage
        }else{
            self.productLogoImageView.image = UIImage()
        }
        
        self.productTitleLabel.text = product.title
        self.productCategoryLabel.text = product.category
        self.productDescriptionLabel.text = product.description
        self.productBarcodeLabel.text = "Barcode: \(product.barcode)"
    }
    
}

@IBDesignable
class CustomImageView:UIImageView{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height * 0.1
    }
}
