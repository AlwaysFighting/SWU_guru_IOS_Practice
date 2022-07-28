import UIKit
import FirebaseCore
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI
import FirebasePhoneAuthUI
import FirebaseEmailAuthUI
import FBSDKLoginKit
import FirebaseFacebookAuthUI

class ViewController: UIViewController, FUIAuthDelegate, LoginButtonDelegate {
    var handle:AuthStateDidChangeListenerHandle!
    let authUI = FUIAuth.defaultAuthUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI!.delegate = self
        let loginButton = FBLoginButton()
        /*let width = loginButton.frame.width
        let height = loginButton.frame.height
        let screen_width = self.view.frame.width
        let screen_height = self.view.frame.height
        loginButton.frame = CGRect(x: screen_width/2-width/2, y: screen_height/2-height/2, width: width, height: height)*/
        
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
      if let error = error {
        print(error.localizedDescription)
        return
      }
        let credential = FacebookAuthProvider
          .credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
              let authError = error as NSError
                print(error.localizedDescription)
                
                return
              }
            }
        }

    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener{
            (auth, user) in
            if let currentUser = auth.currentUser{
                // 로그인이 만약 되었다면
                if let displayName = currentUser.displayName {
                    // 환영메시지를 띄우겠다.
                    let alertController = UIAlertController(title: "Welcome", message: "\(displayName)! Welcome!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: false, completion: nil)}
            }else{
                // 로그아웃된 상태
                let providers: [FUIAuthProvider] = [
                  FUIEmailAuth(),
                  FUIGoogleAuth(),
                  FUIFacebookAuth(),
                  FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!),
                ]
                self.authUI!.providers = providers
                let authVC = self.authUI!.authViewController()
                authVC.modalPresentationStyle = .fullScreen
                self.present(authVC, animated: true,completion: nil)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}

