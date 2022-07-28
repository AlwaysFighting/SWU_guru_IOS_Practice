import UIKit
import FirebaseStorage
import Photos

class ViewController: UIViewController {
    
    let storage = Storage.storage()
    var storageRef:StorageReference!
    var imagePicker:UIImagePickerController!
    var file_name:String!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageRef = storage.reference()
    }

    // 어떤 기능을 구현하고 싶다.
    // 기능을 세분화해서 단계를 나눈다.
    @IBAction func selectImage(_ sender: Any) {
        print("Select Image")
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action_cancle = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // 취소버튼 추가
        actionSheet.addAction(action_cancle)
        
        // 갤러리 버튼 추가
        let action_gallery = UIAlertAction(title: "Gallery", style: .default){
            (action) in
            print("Push Gallery Button")
            switch PHPhotoLibrary.authorizationStatus(){
            case.authorized:
                print("Access Available") // 접근 가능
                self.showGallery()
            case.notDetermined:
                print("Not Authorization") // 접근 가능 없음
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
                    
                }
            default:
                let alertVC = UIAlertController(title: "Permission Required", message: "Access to the gallery is required. Please set it on the settings screen.", preferredStyle: .alert)
                let action_settings = UIAlertAction(title: "Go Settings", style: .default){
                    (action) in
                    print("Go Setting!")
                    // 설정 화면으로 가겠다.(URL 을 통해)
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings,options:[:], completionHandler: nil)
                    }
                }
                let action_cancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
                
                alertVC.addAction(action_settings)
                alertVC.addAction(action_cancle)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
        
        actionSheet.addAction(action_gallery)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
            print("Upload btn pressed")
        guard let image = ImageView.image else {
            let alertVC = UIAlertController(title: "알림", message: "이미지를 선택하고 업로드 기능을 실행하세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        if let data = image.pngData(){
            let imageRef = storageRef.child("images/\(file_name).png")
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            let uploadTask = imageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error{
                    debugPrint(error)
                    return
                }
                guard let metadata = metadata else {
                return
              }
                imageRef.downloadURL { (url, error) in
                  guard let downloadURL = url else{
                  return
                }
                print(downloadURL, "UPload Complete!")
              }
        }
    }
}
}
//  갤러리 띄우는 과정
extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func showGallery() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil) // 사진을 선택하면 앨범은 사라져라!
        // 이미지 정보가 잘 전달되어 오면
        
        // 이미지 정보가 잘 없다면.. return
        guard let selectedImage = info[.originalImage] as? UIImage else{
            return
        }
        
        if let url = info[.imageURL] as? URL {
            file_name = (url.lastPathComponent as NSString).deletingPathExtension
            print(file_name, "filename")
        }
        
        ImageView.image = selectedImage // 선택한 이미지로 바꿔라(이미지뷰에)
        
    }
}

