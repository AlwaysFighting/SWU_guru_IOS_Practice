import UIKit
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class ViewController: UIViewController {

    var person_data = [PersonInfo]() //  배열 형태로 집어넣자. 그리고 변해야 하니까 let 이 아닌 var
    var indicator:NVActivityIndicatorView!
    @IBOutlet weak var personCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), type: .ballSpinFadeLoader, color: .white, padding: self.view.frame.width/2-40)
        indicator.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.view.addSubview(indicator) // indicator 추가하기
        self.view.bringSubviewToFront(indicator) // 애니메이터를 화면 앞쪽으로 빼오기
        indicator.startAnimating() // 애니메이션 시작하기
        getData()
    }

    func getData(){
        print("start loading")
        self.indicator.startAnimating()
        let headers: HTTPHeaders = [
            "app-id": "62c5874add145c0c4b1bd168"
        ]
        AF.request("https://dummyapi.io/data/v1/user?limit=10", headers: headers).responseJSON {response in
        
            switch response.result{
            case .success(let data):
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let dummy_data = try decoder.decode(DummyData.self, from: jsonData)
                    self.person_data = dummy_data.data
                    self.personCollectionView.reloadData()
                    print("finish parsing")
                }catch{
                    debugPrint(error)
                }
            case .failure(let data):
                print("fail")
            default:
                return
            }
            self.indicator.stopAnimating()
        } // insomnia 에서 불러온 URL
        print("finish loading")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = self.personCollectionView.indexPathsForSelectedItems?.first {
            let person_info = person_data[indexPath.row]
            if let vc = segue.destination as? DetailController {
                vc.user_id = person_info.id
            }
        }
    }
}
 
extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person_data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCell", for: indexPath) as! PersonCell
        let data = person_data[indexPath.row]
        
        cell.profileImage.af.setImage(withURL: data.picture)
        cell.idLabel.text = data.id
        cell.nameLabel.text = data.firstName
        cell.mailLabel.text = data.lastName
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 5
        return cell
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 20) / 3 // 한 줄에 3개씩 나눠라
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}


