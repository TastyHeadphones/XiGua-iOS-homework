//
//  ViewController.swift
//  Bug
//
//  Created by Magic Keegan on 2/11/22.
//

import UIKit

class ViewController: UIViewController {
    
//    @IBAction func buttonTapped(_ sender: UIButton){
//        print("按下了按钮。")
//    }
    
    func bugMethod(){
        let array = NSMutableArray()
        
        for i in 0..<10{
            array.insert(i, at: i)
        }
        
        for _ in 0..<10{
            array.removeObject(at: 0)
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton){
        bugMethod()
        print("按下了开关")
        print("sender 是 \(sender)")
        print("打印的位置\(#file) 函数\(#function) 行数\(#line) ")
//        print("开关的状态 \(sender.isOn)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

