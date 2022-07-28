//
//  ViewController.swift
//  NavigationBarBasic
//
//  Created by 목정아 on 2022/06/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 네비게이션 가려주기
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // 다른 화면으로 갈 때는 네비게이션 보이도록 해준다.
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // 네비게이션 버튼 텍스트 설정하기
        self.navigationItem.title = ""
    }
}

