//
//  ThirdViewController.swift
//  ScreenChangeExample
//
//  Created by 목정아 on 2022/06/29.
//

// 스위프트에서 UIKit 을 받아온다.
import UIKit

class ThirdViewController:UIViewController{
    @IBOutlet weak var label: UILabel!
    var label_text = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("Third View Init")
    }
    
    // 이전에 받아온 데이터를 가지고 와서 갱신하겠다.
    // viewWillAppear : 화면이 바뀌기 전에 먼저 데이터를 바꿔놓겠다.
    override func viewWillAppear(_ animated: Bool) {
        self.label.text = self.label_text
    }
    
    // 이전에 받아온 데이터를 가지고 와서 갱신하겠다.
    // viewDidAppear : 화면이 바뀌고 나서 데이터를 바꾸겠다. -> 사용자가 데이터 바뀌는 모습이 보인다.
    override func viewDidAppear(_ animated: Bool) {
        //self.label.text = self.label_text
    }
    
    @IBAction func goBack(_ sender: Any) {
        // 직전으로 돌아가려고 한다. -> 직전에 띄웠던 창이 있는지 확인하는 함수 만들자
        // as? 물음표 뜻 = 만약 없을 수 있으니까 없다면 안 하겠다고 선언하는 것
        if let preVC = self.presentingViewController as? UIViewController {
            // 이전 화면이 dismiss 면 현재 보고 있는 화면을 없애겠다.
            preVC.dismiss(animated: false, completion: nil) // 애니메이션 형태 X / 화면 전환 끝난 다음에 아무 것도 안 할 것이다.
        }
    }
}
