import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var db:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        textView.delegate = self
    }
    
    private func sendFirestore(_ content: String){
        let replaceContent = content.replacingOccurrences(of: "\n", with: "\\n")
        db.collection("post").document().setData(["content":content]){
            err in
            if let err = err{
                print("Error writing document:  \(err)")
            }else{
                print("Document successfully!")
            }
        }
    }

    @IBAction func sendMsg(_ sender: UIButton) {
        sendFirestore(textView.text)
    }

}

extension ViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count % 25 == 0{
            textView.text.append("\n")
        }
    }
}

