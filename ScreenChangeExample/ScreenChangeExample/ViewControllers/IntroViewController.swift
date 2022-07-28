//
//  IntroViewController.swift
//  ScreenChangeExample
//
//  Created by 목정아 on 2022/06/29.
//

import Foundation
import UIKit

class IntroViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("view appear")
        
        // 이벤트를 바로 연결하는 방법 : 스토리보드에 있는 ID 이용하기
        if let storyboard = self.storyboard{
            let vc = storyboard.instantiateViewController(identifier: "firstScreen")
        
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}
