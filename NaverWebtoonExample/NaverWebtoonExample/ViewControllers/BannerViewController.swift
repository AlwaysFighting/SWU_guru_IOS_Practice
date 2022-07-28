import UIKit

class BannerViewController:UIViewController {
    let banner_images = ["banner_01", "banner_02", "banner_03", "banner_04",
                         "banner_05", "banner_06","banner_07", "banner_08",
                         "banner_09", "banner_10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 화면 너비 - 높이 = 125 : 101 -> 너비*101 = 높이*218 -> 높이 = 너비 * 101/125
        let screenSize = UIScreen.main.bounds // 화면 정보
        let width = screenSize.width
        let height = width * 101 / 125
        
        for(index, imageName) in banner_images.enumerated(){
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: CGFloat(index)*width, y: 0, width: width, height: height)
            self.view.addSubview(imageView)
        }
        
        self.view.frame = CGRect(x: 0, y: 0, width: width*CGFloat(banner_images.count), height: height)
    }
}
