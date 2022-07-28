import UIKit
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class DetailController:UIViewController{
    
    var user_id:String!
    var user_info:PersonDetail!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var streetLabele: UILabel!
    
    var indicator:NVActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 전체 크기 설정
        indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), type: .ballZigZag, color: .white, padding: self.view.frame.width/2-40)
        indicator.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator) // 넣는 곳으로 뒤로 가기 때문에 앞으로 빼주는 작업을 해줘야함
        getData(user_id)
    }
    
    func getData(_ user_id:String){
        print("start loading")
        self.indicator.startAnimating() // 애니메이션 시작하기
        let headers: HTTPHeaders = [
            "app-id": "62c5874add145c0c4b1bd168"
        ]
        AF.request("https://dummyapi.io/data/v1/user/\(user_id)", headers: headers).responseJSON {response in
            
            switch response.result{
            case .success(let data):
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    
                    let decoder = JSONDecoder()
                    self.user_info = try decoder.decode(PersonDetail.self, from: jsonData)
                    self.updateInfo()
                    print("finish parsing")
                }catch{
                    debugPrint(error)
                }
            case .failure(let data):
                print("fail")
            default:
                return
            }
            self.indicator.stopAnimating() // 애니메이션 끄기(switch 와 관계없이 무조건)
        } // insomnia 에서 불러온 URL
        print("finish loading")
    }
    
    func updateInfo() {
        print("update_Info : ", user_info)
        
        idLabel.text = user_info.id
        nameLabel.text = "\(user_info.title) \(user_info.firstName) \(user_info.lastName)"
        genderLabel.text = user_info.gender
        dateOfBirthLabel.text = user_info.dateOfBirth
        emailLabel.text = user_info.email
        phoneLabel.text = user_info.phone
        if let address = user_info.location{
            streetLabele.text = "\(address.street), \(address.city), \(address.state), \(address.country)"
        }
        profileImage.af.setImage(withURL: user_info.picture)
    }
}
