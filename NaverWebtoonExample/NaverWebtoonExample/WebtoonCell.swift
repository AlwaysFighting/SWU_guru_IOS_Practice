import UIKit

// 어떤 클래스를 상속 받는다. = 이미 구현된 기능을 가져다 쓰겠다.
// 그 중 일부만 커스터마이징 해서 사용하겠다.
class WebtoonCell:UICollectionViewCell{
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
}

