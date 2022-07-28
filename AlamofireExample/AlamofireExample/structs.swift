// JSON 에서 파싱이 되는 애다! = Codable 붙이자

import UIKit

struct DummyData:Codable {
    let data:[PersonInfo]
    let total:Int
    let page:Int
    let limit:Int
}

struct PersonInfo:Codable {
    let id:String?
    let title:String
    let firstName:String
    let lastName:String
    let picture:URL
}

struct PersonDetail:Codable{
    let id:String?
    let title:String
    let firstName:String
    let lastName:String
    let picture:URL
    let gender:String
    let email:String
    let dateOfBirth:String
    let phone:String
    let location:Location?
}

struct Location:Codable {
    let street:String
    let city:String
    let state:String
    let country:String
    let timezone:String
}
