//
//  SecondViewController.swift
//  NavigationBarBasic
//
//  Created by 목정아 on 2022/06/29.
//

import Foundation
import UIKit

class SecondViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Test2"
    }
}
