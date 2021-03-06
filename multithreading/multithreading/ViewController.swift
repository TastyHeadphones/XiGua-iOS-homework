//
//  ViewController.swift
//  multithreading
//
//  Created by Magic Keegan on 2/15/22.
//

import UIKit

class ViewController: UIViewController {
    
    var viewIsBlue = false
    
    @IBOutlet var task1Indicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func getPhoto(){
        let url = URL(string: "https://lf1-cdn-tos.bytescm.com/obj/static/ies/bytedance_official/_next/static/images/zh-0-1523846a065bd70e69a6462eeabb59d3.jpg")
        DispatchQueue.main.async {
            self.task1Indicator.startAnimating()
        }
        
//        let task = URLSession.shared.dataTask(with: url!) {[weak self] data, response, error in
//            sleep(3)
//            let image = UIImage(data: data!)
//            DispatchQueue.main.async {
//                self?.imageView.image = image
//                self?.task1Indicator.stopAnimating()
//            }
//        }
//        task.resume()
        Task(priority: .background) {
            let (data,_) = try! await URLSession.shared.data(from: url!)
            let image = UIImage(data: data)
                self.imageView.image = image
                self.task1Indicator.stopAnimating()
            
        }
        

        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

