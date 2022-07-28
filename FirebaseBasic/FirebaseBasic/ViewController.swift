import UIKit
import FirebaseAuthUI
import FirebaseEmailAuthUI
import FirebaseGoogleAuthUI
import FirebaseCore

class ViewController: UIViewController, FUIAuthDelegate {

    var handle:AuthStateDidChangeListenerHandle! // 초기화할거니까 신경쓰지마라
    let authUI = FUIAuth.defaultAuthUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI!.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let currentUser = auth.currentUser{
                // 로그인이 만약 되었다면
                if let displayName = currentUser.displayName {
                    // 환영메시지를 띄우겠다.
                    let alertController = UIAlertController(title: "Welcome", message: "\(displayName)! Welcome!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: false, completion: nil)
                }
            }else{
                NSLog("Logged Out")
                // 로그아웃이 되었다면 무시하자
                let googleAuthProvider = FUIGoogleAuth(authUI: self.authUI!)
                let providers: [FUIAuthProvider] = [
                  FUIEmailAuth(),
                  googleAuthProvider,
                ]
                self.authUI!.providers = providers
                let authVC = self.authUI!.authViewController()
                authVC.modalPresentationStyle = . fullScreen
                
                self.present(authVC, animated: false, completion: nil)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!) // 감시자는 화면에 보일 때만 필요하다.
    }
    
    // 로그인이 안되어 있으면 무조건 로그인 창을 켜라
    // 로그아웃 기능 실행 중에 로그인 창을 띄워라
    // 한쪽에 앱을 켜놓고 다른 쪽에 로그인을 했다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Auth.auth().removeStateDidChangeListener(handle!)
    }

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        print("sign in")
        print(authDataResult)
    }
    
    @IBAction func doSignOut(_ sender: Any) {
        // 로그아웃 무조건 될거니까 오류 없으니 do-try 안 쓸것이다. => try 뒤에 ! 써주기 <-> ? 는 없을 수도 있다~ 는 의미
        try?  authUI?.signOut()
    }
}

extension FUIAuthBaseViewController {
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = nil
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    /*open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }*/
}
