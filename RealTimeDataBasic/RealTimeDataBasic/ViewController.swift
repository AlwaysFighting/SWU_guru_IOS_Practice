import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    var ref: DatabaseReference!
    var refHandle:DatabaseHandle!
    var ref2:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // FMDB
        /*
            1. 데이터베이스 저장될 파일을 만든다.
            2. 데이터베이스에 연결
            3. 데이터베이스 초기화
            4. 내용을 기록하고 지우고 수정하고
     */
        /*
        
        
    */
 

        ref = Database.database().reference()
       
        // 새로 데이터 넣을 때 setValue
        guard let key = ref.child("posts").childByAutoId().key else { return }
        let post = ["username": "carrotcarrot",
                    "title": "title"]
        let childUpdates = ["/posts/\(key)": post,
                            "/users/carrotcarrot/\(key)/": post]
        ref.updateChildValues(childUpdates)
        // My top posts by number of stars
        let testQuery = (ref.child("users")).queryOrdered(byChild: "username")
        testQuery.observe(.value) { (snapshot) in
            let testDict = snapshot.value as? [String:AnyObject] ?? [:]
            print(testDict)
        }
        
        /*ref.child("users/\(key)").setValue(["msg":"HI", "username" : "beap", "date":Int(Date().timeIntervalSince1970)]){
            (error:Error?, ref:DatabaseReference) in
              if let error = error {
                print("Data could not be saved: \(error).")
              } else {
                  let alertVC = UIAlertController(title: "Complete", message: "Data saved", preferredStyle: .alert)
                  alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                  self.present(alertVC,animated: true,completion: nil)
              }
        }*/
        // 있는 데이터를 수정할 때 updateChildValues
        // 비동기
        // 순차, 분기, 반복
        ref2 = ref.child("users/1234")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면이 나타나기 직전에 설정한다.
        print("옵저버 등록")
        refHandle = ref.observe(DataEventType.value, with: { snapshot in
            let postDict = snapshot.value as? [String:AnyObject] ?? [:]
            print(postDict)
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 화면이 사라지고 나면 observer 을 삭제한다.
        print("옵저버 삭제")
        //ref2.removeObserver(withHandle: refHandle)
    }
    
    // 내가 특정 순간 혹은 어떤 액션을 취했을 때 딱 한 번만 데이터를 불러오고 싶을 때
    @IBAction func pressBtn(_ sender: Any) {
        ref2.observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as? [String:AnyObject] ?? [:]
            print(data)
        }
    }
    
    @IBAction func removeData(_ sender: Any) {
        ref.child("users/1234/username").child("date").removeValue(){
            (error:Error?, ref:DatabaseReference) in
              if let error = error {
                print("Data could not be saved: \(error).")
              } else {
                  let alertVC = UIAlertController(title: "Complete", message: "Data removed!", preferredStyle: .alert)
                  alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                  self.present(alertVC,animated: true,completion: nil)
              }
        }
    }
    
}

