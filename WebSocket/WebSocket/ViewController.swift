//
//  ViewController.swift
//  WebSocket
//
//  Created by Magic Keegan on 2/19/22.
//

import UIKit

class ViewController: UIViewController,URLSessionWebSocketDelegate {
    
    var webSocket: URLSessionWebSocketTask!
    
    @IBAction func sendMsg(){
        write()
        read()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let session = URLSession(configuration: .default,delegate: self,delegateQueue: OperationQueue())
        
        let url = URL(string: "wss://demo.piesocket.com/v3/channel_1?api_key=oCdCMcMPQpbvNjUIzqtvF1d2X2okWpDQj4AwARJuAgtjhzKxVEjQU6IdCjwm&notify_self")
        
        webSocket = session.webSocketTask(with: url!)
        webSocket.resume()
    }
    
    func connect(){
        webSocket.sendPing { error in
            if let error = error {
                print("ping 的问题为 \(error)")
            }
        }
        
    }
    
    func close(){
        webSocket.cancel(with: .goingAway, reason: "Bye".data(using: .utf8))
    }
    
    func write(){
        webSocket.send(.string("I send a msg \(Date.now)")) { error in
            if let error = error {
                print("write 的问题为 \(error)")
            }
        }
    }
    
    func read(){
        webSocket.receive { result in
            switch result{
            case let .failure(error):
                print(error)
                break
            case let .success(message):
                switch message{
                case let .string(string):
                    print("string is \(string)")
                case let .data(data):
                    print("data is \(data)")
                @unknown default:
                    print("unKnowndata")
                }
                
            }
        }
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("websocket已经连接")
        connect()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("websocket已经断开 原因是 \(reason)")
    }
    
}

