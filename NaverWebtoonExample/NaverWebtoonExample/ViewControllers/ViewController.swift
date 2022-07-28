import UIKit

class ViewController: UIViewController {
    // 구조체 불러오기
    var webtoonData = [
        WebToonData("아는 여자애", "title_01", 9.98, "허니비"),
        WebToonData("환상연가", "title_02", 9.98, "반지운"),
        WebToonData("친애하는 X", "title_03", 9.98, "반지운"),
        WebToonData("하루만 네가 되고 싶어", "title_04", 9.98, "삼"),
        WebToonData("달이 사라진 밤", "title_05", 9.98, "황지음"),
        WebToonData("희란국연가", "title_06", 9.98, "김수지"),
        WebToonData("유미의 세포들", "title_07", 9.98, "이동건"),
        WebToonData("기기괴괴", "title_08", 9.98, "오성대"),
        WebToonData("내 ID는 강남미인!", "title_09", 9.92, "기맹기"),
        WebToonData("스위트홈", "title_10", 9.98, "김칸비/황연찬")
    ]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webtoonData.count // titleImages 개수만큼 리턴하시오
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "webToonCell", for: indexPath) as! WebtoonCell
        // todo : Title, 별점, 작가명 채우기
        let data = webtoonData[indexPath.row]
        cell.titleLabel.text = data.title
        cell.ratingLabel.text = "\(data.rating!)" // optional 을 빼려면 ! 를 넣으면 된다.
        cell.authorLabel.text = data.author
        cell.titleImage.image = UIImage(named: data.title_image)
        
        // border(셀의 테두리 설정)
        cell.layer.borderWidth = 0.3 // 너무 두껍게하면 선이 거슬릴 정도로 나오기 때문
        cell.layer.borderColor = UIColor.lightGray.cgColor // CG 컬러를 UI 컬러로 할당할 수 없기에 나중에 CG 를 써준다.
        
        return cell
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width = self.view.frame.size.width / 3  // 3개씩 들어가도록 하겠다.
        let width = UIScreen.main.bounds.width / 3 // 강제로 화면 크기로 맞추겠다. 
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
