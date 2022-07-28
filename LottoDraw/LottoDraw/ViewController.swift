//
//  ViewController.swift
//  LottoDraw
//
//  Created by 목정아 on 2022/06/28.
//

import UIKit
import FMDB

class ViewController: UIViewController {
    var lottoNumbers = Array<Array<Int>>()
    var databasePath = String() //데이터베이스 경로 설정
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initDB() // DB 초기화 함수 호출
        
        // 데이터베이스 초기화
        // create table (저장 공간을 만들어놓겠다.)
    }

    @IBAction func doLoad(_ sender: Any) {
        print("Load!")
        lottoNumbers = Array<Array<Int>>()
        let db = FMDatabase(path: databasePath)
        if(db.open()){
            let query = "select * from lotto"
            if let result = db.executeQuery(query, withArgumentsIn: []){
                while result.next(){
                    var columnArray = Array<Int>()
                    columnArray.append(Int(result.int(forColumn: "num1"))) // 형변환으로 감싸라
                    columnArray.append(Int(result.int(forColumn: "num2")))
                    columnArray.append(Int(result.int(forColumn: "num3")))
                    columnArray.append(Int(result.int(forColumn: "num4")))
                    columnArray.append(Int(result.int(forColumn: "num5")))
                    columnArray.append(Int(result.int(forColumn: "num6")))
                    
                    lottoNumbers.append(columnArray)
                }
                self.tableView.reloadData()
            }else{
                NSLog("결과 없음")
            }
        }else{
            NSLog("DB Connection Error")
        }
    }
    
    // 로또 생성기
    @IBAction func doDraw(_ sender: Any) {
        lottoNumbers = Array<Array<Int>>() // 초기화하고 내용을 새로 바꿔넣겠다.
        
        var originalNumbers = Array(1...45) // 로또를 45까지 생성하겠다.
        var index = 0 // 추첨된 번호는 0으로 초기화
        
        // for 문으로 5번 추첨하겠다.(한 번 반복할 때)
        for _ in 0...4 {
            originalNumbers = Array(1...45)
            var columnArray = Array<Int>() // 배열선언
            for _ in 0...5{
                // 0부터 originalNumbers 의 하나 작은 값을 뽑겠다.
                index = Int.random(in: 0..<originalNumbers.count)
                columnArray.append(originalNumbers[index])
                originalNumbers.remove(at: index) // 뽑았다면 원본에서 삭제하겠다. (가령 7이 "중복"돼서 나오면 안 되니깐)
            }
            columnArray.sort() // sort() : 숫자가 뒤죽박죽한 것을 깔끔하게 해주겠다.
            lottoNumbers.append(columnArray) // 함께 뽑았다면.. 다시 lottoNumber 에 넣겠다.
        }
        self.tableView.reloadData() // 원하는 내용을 쉽게 업데이트해서 보여준다.
    }
    
    // 데이터베이스
    func initDB(){
        let fileMgr = FileManager.default // 현재 켜져있는 앱 시스템에서 공유 파일에 접근할 수 있는 메서드 (파일 경로 접근)
        // 현재 사용자에게 접근 가능한 폴더 반환 -> 파일 폴더에 접근하자
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0] // 제일 첫 번째 파일로 접근
        
        databasePath = docDir + "/lotto.db" // lotte.db 파일을 만들거다.(파일 생성은 X)
        
        // 만약 데이터베이스가 없다면 만들자
        if !fileMgr.fileExists(atPath: databasePath){
            let db = FMDatabase(path: databasePath) // FM 데이터베이스에서 불러오자
            // 데이터베이스를 열자
            if db.open(){
                // 테이블을 만들기
                // query 란 SQL => 질의응답을 위한 문장
                // autoincrement : 자동으로 증가한다.
                // 글자를 저장하기 위한 컬럼 타입 : text (integer -> text)
                let query = "create table if not exists lotto (id integer primary key autoincrement, num1 integer, num2 integer, num3 integer, num4 integer, num5 integer, num6 integer)"
                if !db.executeStatements(query){
                    NSLog("DB 생성 실패")
                }else{
                    NSLog("DB 생성 성공")
                }
            }
        }else{
            NSLog("DB파일 있음")
        }
     }
    
    // 다른 데이터베이스에다가 로또 당첨 번호를 저장하겠다.
    @IBAction func doSave(_ sender: Any) {
        /*print("Save")
                let db = FMDatabase(path: databasePath)
                if db.open() {
                    try! db.executeUpdate("delete from lotto", values: [])
                    for numbers in lottoNumbers {
                        let query = "insert into lotto(num1, num2, num3, num4, num5, num6) values (\(numbers[0]),\(numbers[1]),\(numbers[2]),\(numbers[3]),\(numbers[4]),\(numbers[5]))"
                        if !db.executeUpdate(query, withArgumentsIn: []) {
                            NSLog("저장 실패")
                        } else {
                            NSLog("저장 성공")
                        }
                    }
                } else {
                    NSLog("DB Connection Error")
                }
            }*/
        print("Save")
        let db = FMDatabase(path: databasePath)
        if db.open(){
            // 기존에 저장했던 데이터베이스를 지우겠다.
            // try! 는 에러날 경우가 전혀 없다고 판단하니 그냥 실행해라 (느낌표!)
            try! db.executeUpdate("delete from lotto", values: [])
            for numbers in lottoNumbers {
                let query = "insert into lotto(num1, num2, num3, num4, num5, num6) values (\(numbers[0]),\(numbers[1]),\(numbers[2]),\(numbers[3]),\(numbers[4]),\(numbers[5]))"
                
                if !db.executeUpdate(query, withArgumentsIn: []){
                    NSLog("DB 저장 실패")
                }else{
                    NSLog("DB 저장 성공")}
            }
        }else{
            NSLog("DB Connection Error")
        }
    }
}

// extension : 해당 위에 있는 컨트롤러 클래스를 확장하겠다.
// 단, 메서드만 생성된다. 변수는 안 만들어진다.
extension ViewController:UITableViewDataSource{
    // section 에 셀이 몇 개인지 확인하는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lottoNumbers.count // 셀 개수 정하기
    }
    
    // Cell 의 내용을 넣어서 반환하는 함수
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell() // 우리가 만든 셀을 쓸 것이다.
        
        // 셀을 불러오는 방법1
        // as! 는 dequeueReusableCell 이 가져오는 것은 LottoCell 타입이라는 것을 캐스팅하는 것
        let cell = tableView.dequeueReusableCell(withIdentifier: "lottoCell", for: indexPath)
            as! LottoCell
        
        let numbers = self.lottoNumbers[indexPath.row]
        cell.label01.text = "\(numbers[0])"
        cell.label02.text = "\(numbers[1])"
        cell.label03.text = "\(numbers[2])"
        cell.label04.text = "\(numbers[3])"
        cell.label05.text = "\(numbers[4])"
        cell.label06.text = "\(numbers[5])"
        
        // 셀을 불러오는 방법2
        /* ! 를 우리가 만들어서 셀이 여러 개 있을 것이라는 것을 알려줌
        indexPath : 현재 몇 번째 줄을 불러올 것인지 알려주기
        cell.textLabel!.text = "\(self.test_data[indexPath.row])"*/
        
        return cell
    }
}
