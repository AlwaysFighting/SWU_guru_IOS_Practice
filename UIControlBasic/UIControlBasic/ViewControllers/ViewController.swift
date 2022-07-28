import UIKit

class ViewController: UIViewController {
    var previousIndex:Int = 0
    var selectedIndex:Int = 0
    
    @IBOutlet var tabBtns: [UIImageView]!
    @IBOutlet weak var tabStackView: UIStackView!
    
    var viewControllers = [UIViewController]()
    
    // 이름은 First, bundle은 없으니 nil
    // stroyboard 네임 : First / identifier : firstView
    static let firstViewController = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "firstView")
    
    static let secondViewController = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "secondView")
    
    static let thirdViewController = UIStoryboard(name: "Third", bundle: nil).instantiateViewController(withIdentifier: "thirdView")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for btn in tabBtns {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tabTapped(_:)))
            btn.isUserInteractionEnabled = true // 유저가 터치하면 인식할 수 있도록 해준다.
            btn.addGestureRecognizer(tap) // 탭을 인식할 수 있는 상태가 된다.
        }
        
        viewControllers.append(ViewController.firstViewController)
        viewControllers.append(ViewController.secondViewController)
        viewControllers.append(ViewController.thirdViewController)
        
        // 첫 번째 화면을 어떻게 띄울 것인가?
        
        // 전체 내부 화면을 불러오기
        let currentVC = viewControllers[0]
        currentVC.view.frame = UIApplication.shared.windows[0].frame
        currentVC.didMove(toParent: self) // 현재 디스플레이된 화면에 들어가자
        self.addChild(currentVC) // 위치를 이동해준다.
        self.view.addSubview(currentVC.view)
        self.view.bringSubviewToFront(tabStackView) // stackView 를 앞으로 끌고 나와라
        
    }
    
    // 탭 버튼을 터치하면 화면 전환 함수
    @objc func tabTapped(_ sender:UITapGestureRecognizer){
            if let tag = sender.view?.tag {
                previousIndex = selectedIndex
                selectedIndex = tag
            
            let previousVC = viewControllers[previousIndex]
            previousVC.willMove(toParent: self)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
            
            let currentVC = viewControllers[selectedIndex]
            currentVC.view.frame = UIApplication.shared.windows[0].frame
            currentVC.didMove(toParent: self)
            self.addChild(currentVC)
            self.view.addSubview(currentVC.view)
            
            self.view.bringSubviewToFront(tabStackView)
        }
    }

}

