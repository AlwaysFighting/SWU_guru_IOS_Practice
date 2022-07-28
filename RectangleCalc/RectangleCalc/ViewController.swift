//
//  ViewController.swift
//  RectangleCalc
//
//  Created by 목정아 on 2022/07/01.
//

import UIKit

class ViewController:
                        
    UIViewController {


    @IBOutlet weak var widthField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var calcField: UITextField!
    
    let numberFormatter:NumberFormatter = {
            let nf = NumberFormatter()
            nf.numberStyle = .decimal
            nf.minimumFractionDigits = 0
            nf.maximumFractionDigits = 3
            return nf
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func RecCalculation(_ sender: Any) {
        if let heightText = heightField.text, let height = Double(heightText), let widthText = widthField.text, let width = Double(widthText) {
                    let calc = width * height
            calcField.text = numberFormatter.string(from: NSNumber(value: calc))
                }
        
    }
    
    
    @IBAction func textFieldFinishEdit(_ sender: UITextField) {
        view.resignFirstResponder()
    }
    
    
    @IBAction func textEndEditing(_ sender: Any) {
        widthField.resignFirstResponder()
        heightField.resignFirstResponder()
    }
}

