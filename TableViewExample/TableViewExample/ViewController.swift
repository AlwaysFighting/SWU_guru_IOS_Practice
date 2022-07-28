import UIKit

// UITableViewDataSource 상속해서 꼭 하기!
// UITableViewDelegate : 테이블 뷰의 액션이 나오면 대신 처리해주겠다. (스와이핑 액션)
class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    var datasource:[String] = []
    @IBOutlet weak var memoText: UITextField!
    
    override func viewDidLoad() {
        // 뷰 인스턴스가 메모리에 올라왔고, 아직 화면은 뜨지 않은 상황
        super.viewDidLoad()
        
        // 위에서 아래로 스와이핑하면 새로고침 아이콘? 을 만들겠다.
        let refreshControl = UIRefreshControl()
        // 리프레시 아이콘 색상 변경
        refreshControl.tintColor = .cyan
        // 데이터를 갖고오면 컨트롤 멈추겠다.
        refreshControl.addTarget(self, action: #selector(fetchData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        // 화면을 꺼도 데이터가 고유하게 남는다. 
        let userDefault = UserDefaults.standard
        if let value = userDefault.array(forKey: "MemoData") as? [String]{
            print(value, "from User Default")
            self.datasource = value
        }
        
    }
    
    // 새로고침 함수
    @objc func fetchData(_ sender:Any){
        tableView.refreshControl?.endRefreshing() // refresh 가 없을 수 있으니 ? 가 있어야함
        
    }

    // 누를 때마다 편집이 바뀌도록 하겠다.
    @IBAction func changeEditing(_ sender: UIBarButtonItem) {
        //self.tableView.isEditing = !self.tableView.isEditing
        self.tableView.isEditing.toggle()
    }
    
    
    // 메인 화면에 나타나기 직전에 네비게이션바를 숨기겠다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 나타나기 직전에
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // 사라지기 직전에 네비게이션을 다시 보여주겠다.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //
    @IBAction func addMemo(_ sender: Any) {
        
        // 내용이 없으면 아무것도 안 할 것이다. 또한, 메모의 내용이 아무것도 없다면 출력을 안 할 것이다.
        guard let memo = memoText.text, memo != "" else{
            return
        }
        self.datasource.append(memo)
        memoText.text = ""
        
        self.saveData()
        self.tableView.reloadData()
    }
    
    func saveData(){
        let userDefault = UserDefaults.standard
        userDefault.setValue(datasource, forKey: "MemoData")
        userDefault.synchronize()
    }
}

// ViewController 을 확장한다고 선언
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count // 데이터를 몇 줄 띄울 것인가?
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // attribute 에서 설정한거 가지고 온다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! memoCell
        let row = indexPath.row
        cell.memoLabel.text = "\(datasource[row])"
        cell.numLabel.text = "\(row + 1)"
        return cell
    }

    // 해당 줄이 editing 이 되는가?
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 해당 줄의 위치를 바꿀 수 있도록 하겠다.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let fromRow = sourceIndexPath.row
        let toRow = destinationIndexPath.row
        let data = datasource[fromRow]
        datasource.remove(at: fromRow)
        datasource.insert(data, at: toRow)
        saveData()
        tableView.reloadData()
    }

    // 셀 왼쪽 시작부분에 나타날 버튼들
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let btnShare = UIContextualAction(style: .normal, title: "Share") {(action, view, completion) in completion(true)
    }
        return UISwipeActionsConfiguration(actions: [btnShare])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "goDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height/12
    }
}

extension ViewController:UITableViewDelegate{
    
    // 들여쓰기 안 함(아이콘이)
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // Editing 스타일 바꾸기
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // 셀 오른쪽 끝에 나타날 버튼들
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let btnEdit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            
            // edit 버튼을 눌렀을 때 "경고창"을 띄우겠다.
            let editAlert = UIAlertController(title: "Edit memo", message: "change your memo", preferredStyle: .alert)
            
            editAlert.addTextField { (textField) in
                textField.text = self.datasource[indexPath.row]
            }
            // 코드 수정하기
            editAlert.addAction(UIAlertAction(title: "Modify", style: .default, handler: {(action) in
                // 텍스트 불러오기
                if let fields = editAlert.textFields, let textField = fields.first, let text = textField.text {
                    self.datasource[indexPath.row] = text
                    //self.tableView.reloadData()
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                    self.saveData()
                }
            }))
            
            editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(editAlert, animated: true, completion: nil) // 화면에 띄우겠다.
            completion(true)
        }
        // 삭제 버튼 만들기
        let btnDelete = UIContextualAction(style: .destructive, title: "Del") { (action, view, completion) in
            
            // 데이터베이스에서도 지우고
            let row = indexPath.row
            self.datasource.remove(at: row)
            
            // 화면에서도 지우고 데이터를 저장하겠다.
            //tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            self.saveData()
            completion(true)
        }
        btnEdit.backgroundColor = .blue
        btnDelete.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [btnDelete, btnEdit])
    }
}
