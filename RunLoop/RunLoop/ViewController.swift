//
//  ViewController.swift
//  RunLoop
//
//  Created by Magic Keegan on 2/16/22.
//

import UIKit

class ViewController: UIViewController {
    var newThread:Thread!
    
    @IBAction func tapped(){
        print("按钮按下了")
        self.perform(#selector(log), on: self.newThread, with: nil, waitUntilDone: false)
    }
    
    @objc func log(){
        print("子线程 \(Thread.current)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("主线程 \(Thread.current)")
        
        self.newThread = Thread.init(block: {
            print("子线程 \(Thread.current)")
            RunLoop.current.add(NSMachPort(), forMode: .default)
            let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0) { observer, activity in
                switch activity{
                case .entry:
                    NSLog("entry")
                    break
                case .beforeTimers:
                    NSLog("beforeTimers")
                    break
                case .beforeSources:
                    NSLog("beforeSources")
                    break
                case .beforeWaiting:
                    NSLog("beforeWaiting")
                    break
                case .afterWaiting:
                    NSLog("afterWaiting")
                    break
                case .exit:
                    NSLog("exit")
                    break
                default:
                    break
                }
            }
            
            CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, .defaultMode)
            RunLoop.current.run()
        })
        
        
        self.newThread.name = "子线程"
        self.newThread.start()
        
        // Do any additional setup after loading the view.
    }
}

