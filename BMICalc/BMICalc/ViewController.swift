//
//  ViewController.swift
//  BMICalc
//
//  Created by 목정아 on 2022/06/28.
//

import UIKit

class ViewController: UIViewController {
    
    // 소수점 제한하기
    let numberFormatter:NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()
    
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var bmiField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    @IBAction func bmiCalculation(_ sender: Any) {
        if let heightText = heightField.text, let height = Double(heightText), let weightText =
            weightField.text, let weight = Double(weightText){
            let bmi = weight / ((height / 100)*(height / 100))
            bmiField.text = "\(bmi)"
            
            // 소수점 제한하기
            bmiField.text = numberFormatter.string(from: NSNumber(value: bmi))
        }
        view.endEditing(true)
    }
    
    // 특정 공간을 누르면 키보드가 사라진다.
    @IBAction func textFieldFinishEdit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    // 마우스가 화면을 터치하면 키보드가 사라진다.
    @IBAction func textEndEditing(_ sender: Any) {
        /*마우스가 여백을 터치하면 키보드가 사라진다.
        weightField.resignFirstResponder()
        heightField.resignFirstResponder()*/
        
        // 한꺼번에 할 수 있는 함수
        view.endEditing(true)
    }
}

