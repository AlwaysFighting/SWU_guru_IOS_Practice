//
//  SecondViewController.swift
//  ScreenChangeExample
//
//  Created by 목정아 on 2022/06/29.
//

import UIKit

class SecondViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 세 번째 화면 넘어가기 바로 직전에 나오는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ThirdViewController{
            destination.label_text = "test"
        }
    }
}
