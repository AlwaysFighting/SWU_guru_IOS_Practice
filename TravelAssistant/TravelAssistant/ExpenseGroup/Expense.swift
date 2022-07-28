import SwiftUI

struct Expense:Identifiable, Hashable{
    var id = UUID().uuidString
    var remark:String
    var amount:Double
    var date:Date
    var type:ExpenseType
    var color:String
}

enum ExpenseType:String{
    case income = "수입"
    case expense = "지출"
    case all = "ALL"
}

var sample_expenses: [Expense] = [
    Expense(remark: "비행기표", amount: 300, date: Date(timeIntervalSince1970: 1652987245), type: .expense, color: "Red"),
    Expense(remark: "음식값", amount: 100, date: Date(timeIntervalSince1970: 1652814445), type: .expense, color: "Purple"),
    Expense(remark: "숙소값", amount: 200, date: Date(timeIntervalSince1970: 1652814445), type: .expense, color: "Red"),
    Expense(remark: "기념품값", amount: 60, date: Date(timeIntervalSince1970: 1652296045), type: .expense, color: "Yellow"),
    Expense(remark: "지인 선물", amount: 90, date: Date(timeIntervalSince1970: 1651864045), type: .expense, color: "Purple"),
    Expense(remark: "렌트값", amount: 130, date: Date(timeIntervalSince1970: 1651432045), type: .expense, color: "Purple")
]

