//
//  ViewController.swift
//  GCD
//
//  Created by Magic Keegan on 2/13/22.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let operationQueue = OperationQueue()
//        operationQueue.maxConcurrentOperationCount = 1
        let op1 = BlockOperation {
            print("这是第一步")
            sleep(3)
        }
        let op2 = BlockOperation {
            print("这是第二步")
            sleep(1)
        }
        let op3 = BlockOperation {
            print("这是第三步")
        }
        
        op3.addDependency(op2)
        op2.addDependency(op1)
        operationQueue.addOperation(op2)
        operationQueue.addOperation(op1)
        operationQueue.addOperation(op3)
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

