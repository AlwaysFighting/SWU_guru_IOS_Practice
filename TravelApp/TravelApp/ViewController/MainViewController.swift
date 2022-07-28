import UIKit

class MainViewController:UIViewController{
    
    @IBOutlet weak var bannerScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerViewController = MainBannerController()
        bannerScrollView.addSubview(bannerViewController.view)
    }
}
