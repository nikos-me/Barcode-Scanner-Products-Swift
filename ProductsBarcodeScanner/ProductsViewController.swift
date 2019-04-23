//
//  ProductsViewController.swift
//  ProductsBarcodeScanner
//
//  Created by Nikos Menexis on 23/04/2019.
//  Copyright © 2019 Nikos Menexis. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, ScanBarcodeProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var products = [
                    Product(id: "293767925", title: "iPhone", description: "test desc", barcode: "62516281637931", category: "SmartPhones", logoImage: UIImage(named: "iphone")),
                    Product(id: "24324", title: "Watch", description: "test desc", barcode: "62516281637931", category: "Watches", logoImage: UIImage(named: "watch")),
                    Product(id: "12443", title: "Drone", description: "test desc", barcode: "62516281637931", category: "Gadgets", logoImage: UIImage(named: "drone")),
                    Product(id: "2344234", title: "Shoe", description: "test desc", barcode: "62516281637931", category: "Shoes", logoImage: UIImage(named: "shoes")),
                    Product(id: "2354255", title: "HeadPhones", description: "test desc", barcode: "62516281637931", category: "Gadgets", logoImage: UIImage(named: "headPhones"))
                    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
    }
    
    func productScanned(product: Product) {
        self.products.insert(product, at: 0)
    }
}

// MARK: - Table View methods
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = Bundle.main.loadNibNamed("ProductTableViewCell", owner: self, options: nil)?.first as? ProductTableViewCell else{return UITableViewCell()}
        cell.selectionStyle = .none
        cell.setUpCell(product: self.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118.0
    }
    
}
