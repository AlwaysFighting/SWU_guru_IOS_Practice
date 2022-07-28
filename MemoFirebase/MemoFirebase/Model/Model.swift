import Foundation

class Memo{
    var content:String
    var insertDate:Date
    
    init(content:String){
        self.content = content
        insertDate = Date()
    }
    
    static var dummyMemoList = [
    Memo(content: "Hello"),
    Memo(content: "I'm studying XCODE")]
}
