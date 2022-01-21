//
//  QRCodeViewController.swift
//  General framework
//
//  Created by Magic Keegan on 1/21/22.
//

import UIKit

class QRCodeViewController: UIViewController {
    @IBOutlet var QRcode: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QRcode.image = generateQRCode(from: "{ \"category\": \"food\", \"no\": 1800023 }")

        // Do any additional setup after loading the view.
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
