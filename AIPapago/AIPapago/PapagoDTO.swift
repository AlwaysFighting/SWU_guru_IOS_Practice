import UIKit
import ObjectMapper

class PapagoDTO: Mappable {
    var message : Message?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        message <- map["message"]
    }
    
    class Message : Mappable {
        var result : Result?
        
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            result <- map["result"]
        }
        
        class Result : Mappable{
            
            var translatedText : String?
            
            required init?(map: Map) {
                
            }
            
            func mapping(map: Map) {
                translatedText <- map["translated"]
            }
        }
        
    }
}
