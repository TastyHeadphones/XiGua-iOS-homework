//
//  File.swift
//  mess around
//
//  Created by Magic Keegan on 1/13/22.
//

import SwiftUI
import Foundation

struct Light {
    var status:Bool = false
    var color:Color = .gray
}

class Lights{
    static var sharedInstance = Lights()
    var trueCount = 0
    var lights = [[Light]]()
    
    init(){
        self.newLights()
    }
    
    
    
    //生成矩阵
    func newLights(){
        //初始化矩阵大小
        let size:Int = 5
        self.trueCount = 0
        var arr = [[Light]]()
        for _ in 0..<size{
            var rowArr = [Light]()
            for _ in 0..<size{
                let light = Light(status: Bool.random(), color: [Color.blue,Color.red,Color.green].randomElement()! )
                if light.status{
                    self.trueCount += 1
                }
                
                rowArr.append(light)
            }
            arr.append(rowArr)
        }
        self.lights = arr
    }
    
    

    
}


