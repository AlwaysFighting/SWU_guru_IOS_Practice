import UIKit
import Parchment

class DailyWebtoonListViewController:UIViewController{
    
    var pagingViewController:PagingViewController!
    var viewControllers:[ViewController] = [] // 초기화는 해놓아야 한다.
    let dayTitles = ["월","화","수","목","금","토","일"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for title in dayTitles{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "webtoonListView") as? ViewController{
                vc.title = title
                viewControllers.append(vc)
            }
        }
        pagingViewController = PagingViewController(viewControllers:viewControllers)
        pagingViewController.menuItemSize = .sizeToFit(minWidth: 30, height: 40)
        pagingViewController.menuItemSpacing = 0
        pagingViewController.menuItemLabelSpacing = 0
        pagingViewController.indicatorOptions = .hidden
        pagingViewController.selectedBackgroundColor = .systemGreen
        pagingViewController.selectedTextColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addChild(pagingViewController)
        pagingViewController.view.frame = self.view.frame
        view.addSubview(pagingViewController.view) // subView : 화면에 띄울 것
        pagingViewController.didMove(toParent: self)
    }
}
