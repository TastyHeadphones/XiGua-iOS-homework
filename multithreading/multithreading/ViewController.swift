//
//  ViewController.swift
//  multithreading
//
//  Created by Magic Keegan on 2/15/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var task1Indicator: UIActivityIndicatorView!
    @IBOutlet var task2Indicator: UIActivityIndicatorView!
    @IBOutlet var task3Indicator: UIActivityIndicatorView!
    
    func task1(){
        DispatchQueue.main.async {
            self.task1Indicator.startAnimating()
        }
        sleep(1)
        DispatchQueue.main.async {
            self.task1Indicator.stopAnimating()
        }
        
    }
    
    func task2(){
        DispatchQueue.main.async {
            self.task2Indicator.startAnimating()
        }
        sleep(2)
        DispatchQueue.main.async {
            self.task2Indicator.stopAnimating()
        }
    }
    
    func task3(){
        DispatchQueue.main.async {
            self.task3Indicator.startAnimating()
        }
        sleep(3)
        DispatchQueue.main.async {
            self.task3Indicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let op1 = BlockOperation{
            self.task1()
        }
        let op2 = BlockOperation{
            self.task2()
        }
        let op3 = BlockOperation{
            self.task3()
        }
        let queue = OperationQueue()
        queue.addOperation(op1)
        
        op1.completionBlock = {
            queue.addOperation(op2)
        }
        op2.completionBlock = {
            queue.addOperation(op3)
        }
        
//        let queue = OperationQueue()
//
//        op3.addDependency(op1)
//        op3.addDependency(op2)
//
//        queue.addOperation(op1)
//        queue.addOperation(op2)
//        queue.addOperation(op3)
        
        
//        DispatchQueue.global().async {
//
//            self.task2()
//            self.task3()
//        }
//        DispatchQueue.global().async {
//            self.task2()
//        }
//        DispatchQueue.global().async {
//            self.task3()
//        }

        
        // Do any additional setup after loading the view.
    }


}

