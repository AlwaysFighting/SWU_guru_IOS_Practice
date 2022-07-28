import SwiftUI
import FirebaseCore
import FirebaseFirestoreSwift

struct Post:Identifiable, Codable{
    @DocumentID var id:String?
    var title:String
    var author:String
    var postContent:[postContent]
    var date: Timestamp
    
    enum codingKeys: String, CodingKey{
        case id
        case title
        case author
        case postContent
        case date
    }
}

// post Content
struct postContent:Identifiable, Codable{
    var id = UUID().uuidString
    var value:String
    var type:PostType
    
    enum CodingKeys: String, CodingKey{
        case id
        // since firestore keyname is key..
        case type = "key"
        case value
    }
}

// content type
enum PostType: String, CaseIterable, Codable{
    
    case Header = "Header"
    case SubHeading = "SubHeading"
    case paragraph = "Paragraph"
    case Image = "Image"
    
}
