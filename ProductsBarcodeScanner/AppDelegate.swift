//
//  AppDelegate.swift
//  ProductsBarcodeScanner
//
//  Created by Nikos Menexis on 23/04/2019.
//  Copyright © 2019 Nikos Menexis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var products = [Product]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        generateProducts { (prs) in
            self.products = prs
        }
        
        return true
    }
    
    static func shared()->AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private func generateProducts(completion: @escaping ([Product]) -> Void){
        
        let tempProducts = [
                            Product(id: "293767925", title: "iPhone", description: "test desc", barcode: "62516281637931", category: "SmartPhones", logoImage: UIImage(named: "iphone")),
                            Product(id: "24324", title: "Watch", description: "test desc", barcode: "62516281637931", category: "Watches", logoImage: UIImage(named: "watch")),
                            Product(id: "12443", title: "Drone", description: "test desc", barcode: "62516281637931", category: "Gadgets", logoImage: UIImage(named: "drone")),
                            Product(id: "2344234", title: "Shoe", description: "test desc", barcode: "62516281637931", category: "Shoes", logoImage: UIImage(named: "shoes")),
                            Product(id: "2354255", title: "HeadPhones", description: "test desc", barcode: "62516281637931", category: "Gadgets", logoImage: UIImage(named: "headPhones")),
                            Product(id: "12353542", title: "Backpack", description: "test desc", barcode: "62516281637931", category: "Backpacks", logoImage: UIImage(named: "bag"))
                        ]
        
        completion(tempProducts)
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

