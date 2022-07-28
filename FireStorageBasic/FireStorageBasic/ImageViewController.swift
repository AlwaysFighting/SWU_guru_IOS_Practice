import UIKit
import FirebaseStorage

class ImageListViewController:UIViewController {
    let storage = Storage.storage()
    var storageRef:StorageReference!
    var urls:[URL] = []
    
    @IBOutlet weak var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageRef = storage.reference()
        storageRef.child("images").listAll { (result, error) in
            if let error = error {
                debugPrint(error)
                return
            }
            self.urls = []
            
            for item in result!.items {
                print(item.fullPath)
                self.storageRef.child(item.fullPath).getData(maxSize: 40 * 1024 * 1024) { (data, error) in
                    print("get data")
                    if let data = data {
                        self.imageView.image = UIImage(data: data)
                    }
                }
//                item.downloadURL { (url, error) in
//                    guard let url = url else {
//                        print("url not exits")
//                        return
//                    }
//                    self.urls.append(url)
//                    debugPrint(self.urls)
//                }
              }
        }
    }
}