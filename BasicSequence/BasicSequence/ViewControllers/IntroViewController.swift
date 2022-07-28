//
//  IntroViewController.swift
//  BasicSequence
//
//  Created by 목정아 on 2022/06/29.
//

//import Foundation
import UIKit
import SwiftyGif

class IntroViewController:UIViewController{
    @IBOutlet weak var intro_image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            let gif = try UIImage(gifName: "intro.gif")
            self.intro_image.setGifImage(gif, loopCount: 1) // loopCount : -1 은 무한재생하라는 의미
            self.intro_image.delegate = self
        } catch{
            NSLog("재생불가")
        }
        // 로딩이 필요한 정보가 있다면 이때 로드를 완료하고 화면을 전환한다.
    }
    // 화면 나타난 후에 타이머를 잴 것이다.
    override func viewDidAppear(_ animated: Bool) {
        // 몇 초 후에 화면을 전환하겠다.
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
           if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainView"){
               self.goMainView() // self 를 써서 IntroViewController 에 있는 것을 호출하겠다고 명확하게 알려줘야함.
           }
        }
    }
}

extension IntroViewController:SwiftyGifDelegate{
    func gifDidStop(sender: UIImageView) {
            print("gifDidStop")
        }
    func goMainView(){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainView"){
            // mainView 에 있다면 풀 스크인으로 띄어라
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true,completion: nil)}
        }
}
