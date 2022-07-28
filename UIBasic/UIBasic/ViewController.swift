//
//  ViewController.swift
//  UIBasic
//
//  Created by 목정아 on 2022/06/27.
//

import UIKit

class ViewController: UIViewController {

    /*
     UI 요소들을 연결하는 방식
     IBOutlet : UI 요소들 변수와 연결하는 것
     IBAction : UI 요소의 이벤트를 연결하는 것
     */
    
    /* ! 로 나타난 것은 값이 무조건 있다는 의미 */
    @IBOutlet weak var label1: UITextField!
    @IBOutlet weak var label2: UITextField!
    
    // 소수점 제한하기
    let numberFormatter:NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal // decimal 타입으로 정한다.
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("앱 화면이 나타납니다.")
    }

    @IBAction func doConvert(_ sender: UIButton) {
        /* optional 이 있다면 unwraping 할 것이다. */
        /* var 은 변수, let 은 상수 */
        // if let -> 값이 있으면 옵션을 하는 경우 true, 아니면 flase
        if let value1 = label1.text, let number1 = Double(value1){
            // 섭씨 * 1.8 + 32 = 화씨
            let fahrenheit = number1 * 1.8 + 32
            label2.text = "\(fahrenheit)" /* 문자형 변환 */
            label2.text = numberFormatter.string(from: NSNumber(value: fahrenheit)) // 형 변환해서 넣겠다.
        
            // 키보드를 없애주겠다. (키보드가 필요 없는 상태 인식)
            //label1.resignFirstResponder()
        }
        print("Press Button")
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        // 아무 곳이나 탭했을 때 키보드가 사라지도록 한다.
        label1.resignFirstResponder()
        label2.resignFirstResponder()
    }
}

