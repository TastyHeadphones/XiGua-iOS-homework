//
//  ViewController.swift
//  Synchronize
//
//  Created by Magic Keegan on 2/15/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "https://lf1-cdn-tos.bytescm.com/obj/static/ies/bytedance_official/_next/static/images/zh-4-26c4957719a3e65eb6054907f14fde98.jpg")
        let task = URLSession.shared.dataTask(with: url!) {[weak self]data, response, error in
            let image = UIImage(data: data!)
            DispatchQueue.main.sync {
                self?.imageView.image = image
            }
        }
        task.resume()
        
    }


}

