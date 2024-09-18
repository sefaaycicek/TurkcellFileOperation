//
//  ViewController.swift
//  TurkcellFileOperation
//
//  Created by Sefa Aycicek on 18.09.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        /*DispatchQueue.global().async { // background thread içerisinde işlemi başlar
            self.saveFiles()
        }*/
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
            self.saveFiles()
        }
        
        callApi { prm in
            self.view.backgroundColor = UIColor.yellow
            //Thread.isMainThread -> true
        }
        
        print("") // yukardaki satırda beklemez, burdan devam eder çalışmaya.
    }
        
    func callApi(onSuccess : @escaping (String)->()) {
        DispatchQueue.global().async {
            // request at
            var data = try? Data(contentsOf: URL(string: "https://www.google.com/image.jpg")!)
            //Thread.isMainThread -> false
            
            DispatchQueue.main.async {
                //Thread.isMainThread -> true
                onSuccess("response")
            }
        }
    }
    
    func saveFiles() {
        // document directory
        // cache directorory
        // temporary directory
        
        
        let fileManager = FileManager.default
        
        /*Bundle.main
         UIScreen.main
         UIDevice.current*/
        
        var str = "metin"
        var image = UIImage(named: "ic_favorite_red")
        var image2 = #imageLiteral(resourceName: "ic_favorite_red.pdf")
        
        
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
        }
        
        if let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            print(cachesDirectory)
            
            
            let filePath = cachesDirectory.appendingPathComponent("temp_image.jpg")
            var imageData = image?.jpegData(compressionQuality: 1.0)
            
            let textFilePath = cachesDirectory.appendingPathComponent("temp.txt")
            var strData = str.data(using: .utf8, allowLossyConversion: true)
            
            
            do {
                if fileManager.fileExists(atPath: filePath.absoluteString) {
                    try fileManager.removeItem(at: filePath)
                }
                
                try imageData?.write(to: filePath)
                try strData?.write(to: textFilePath)
            } catch {
                print("dosya yazarken hata \(error)")
            }
            
            if let imageData = try? Data(contentsOf: filePath) {
                let newImage = UIImage(data: imageData)
            }
            
            if let metin = try? Data(contentsOf: textFilePath), let stringMetin = String(data: metin, encoding: .utf8), !stringMetin.isEmpty {
                
            }
            
        }
        
        
        DispatchQueue.main.async { // Background'daki akışı UI thread'e taşımak için
            self.view.backgroundColor = UIColor.red
        }
    }
}

