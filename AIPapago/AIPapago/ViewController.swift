import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     let url = "https://openapi.naver.com/v1/papago/n2mt"
        let params = ["source":"ko",
                  "target":"en",
                  "text":"만나서 반갑습니다."]
        let header = ["Content-Type":"application/x-www-form-urlencoded; charset=UTF-8",
            "X-Naver-Client-Id":"NK3qLYjdGSgr0iYIXFdO",
            "X-Naver-Client-Secret":"qh414SGMV0"]

        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default ,headers: header).responseObject{(response:DataResponse<PapagoDTO>) in
            let papagoDTO = response.result.value
            print(papagoDTO?.message?.result?.translatedText as Any)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

