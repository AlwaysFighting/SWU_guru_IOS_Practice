import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        // 데이터 추가
        db.collection("cities").document("Korea").setData([
            "name": "Korea",
            "state": "SW",
            "country": "Seoul"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        // 데이터 읽기
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        // lastUpdated : 서버쪽 시간을 자동 저장
        let washingtonRef = db.collection("cities").document("DC")
        washingtonRef.setData([
            "name": "Korea",
            "state": "SW",
            "country": "Seoul",
            "lastUpdated": FieldValue.serverTimestamp(),
        ])
        
        // Set the "capital" field of the city 'DC'
        washingtonRef.updateData([
            "capital": true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        // 중첩된 객체의 필드 업데이트(데이터 추가)
        let frankDocRef = db.collection("users").document("frank")
        frankDocRef.setData([
            "name": "Frank",
            "favorites": [ "food": "Pizza", "color": "Blue", "subject": "recess" ],
            "age": 12
            ])

        // To update age and favorite color:
        db.collection("users").document("frank").updateData([
            "age": 13,
            "favorites.color": "Red"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}

