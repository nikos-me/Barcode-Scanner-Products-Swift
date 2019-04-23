//
//  BarcodeScannerViewController.swift
//  ProductsBarcodeScanner
//
//  Created by Nikos Menexis on 23/04/2019.
//  Copyright © 2019 Nikos Menexis. All rights reserved.
//

import UIKit
import AVFoundation

// Send the scanned product with delegate
protocol ScanBarcodeProtocol {
    func productScanned(product:Product)
}

class ScanBarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // IBOutlets
    @IBOutlet weak var videoPreview: UIView!
    @IBOutlet weak var barcodeIndexView: UIView!
    
    var barcode = ""
    var products = [Product]()
    
    let avCaptureSession = AVCaptureSession()
    var video = AVCaptureVideoPreviewLayer()
    var barcodeDelegate:ScanBarcodeProtocol?
    
    // Handle errors
    enum error:Error{
        case noCameraAvailable
        case videoInputInitFail
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Scanner"
        
        self.products = AppDelegate.shared().products
        
        scanQRCode()
        
    }
    
    // Setup the views and start scanning
    func scanQRCode(){
        
        do{
            guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else{
                print("No camera available.")
                throw error.noCameraAvailable
            }
            
            guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else{
                print("Faild to init camera.")
                throw error.videoInputInitFail
            }
            
            let avCaptureMetadataOutput = AVCaptureMetadataOutput()
            avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            avCaptureSession.addInput(avCaptureInput)
            avCaptureSession.addOutput(avCaptureMetadataOutput)
            
            avCaptureMetadataOutput.metadataObjectTypes = [.ean13]
            
            let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
            avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            avCaptureVideoPreviewLayer.frame = videoPreview.bounds
            self.videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
            self.videoPreview.bringSubviewToFront(barcodeIndexView)
            
            avCaptureSession.startRunning()
        }catch{
            print("Failed to scan the QR/Barcode.")
        }
    }
    
    // Get the scanned data and send the barcode to the next function
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if (metadataObjects.count > 0){
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.ean13{
                    if let text =  object.stringValue{
                        self.avCaptureSession.stopRunning()
                        searchForProduct(barcode: text)
                    }
                }
            }
        }
    }
    
    // Search for the product
    func searchForProduct(barcode:String){
        self.avCaptureSession.startRunning()
    
        checkIfProductExists(productBarcode: barcode) { (pr) in
            
            if let actualProduct = pr{
                if let actualDelegate = self.barcodeDelegate{
                    self.avCaptureSession.stopRunning()
                    actualDelegate.productScanned(product: actualProduct)
                    DispatchQueue.main.async {
                        self.presentAlertWithActions(title: "We found a product!", message: "Success", buttonTitle: "ΟΚ", vc: self, completion: {
                            self.navigationController?.popToRootViewController(animated: true)
                        })
                        self.avCaptureSession.startRunning()
                    }
                }
            }
        }
        
    }
    
    private func checkIfProductExists(productBarcode:String, completion: @escaping (Product?) -> Void){
        
        if let index = products.firstIndex(where: {$0.barcode == productBarcode}){
            
            completion(products[index])
        }
        completion(nil)
    }
    
    // Present Alert
    func presentAlertWithActions(title:String,message:String, buttonTitle:String, vc:UIViewController, completion: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default) { (action) in
            completion()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}




