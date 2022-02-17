//
//  ViewController.swift
//  async_await
//
//  Created by Magic Keegan on 2/16/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spiner: UIActivityIndicatorView!
    
    @IBAction func getPhoto(){
        let url = URL(string: "https://lf1-cdn-tos.bytescm.com/obj/static/ies/bytedance_official/_next/static/images/zh-0-1523846a065bd70e69a6462eeabb59d3.jpg")
        spiner.startAnimating()
        
//        let task = URLSession.shared.dataTask(with: url!) {[weak self] data, response, error in
//            sleep(3)
//            let image = UIImage(data: data!)
//            DispatchQueue.main.async {
//                self?.imageView.image = image
//                self?.spiner.stopAnimating()
//            }
//        }
//
//        task.resume()
        Task(priority: .background) {
            sleep(3)
            let (data,_) = try! await URLSession.shared.data(from: url!)
            let image = UIImage(data: data)
            self.imageView.image = image
            self.spiner.stopAnimating()
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

