import UIKit

var greeting = "Hello, playground" // 변수(가변성)
let greetings = "Hello SWU" // 상수(불변성)
var grettings:String = "" // 형이 한 번 지정되면 변하면 X
var number1:Int = 333
var number2:Double = 3.14
// NS <- Nest Step

// 문자열 안에 변수들을 넣을 수 있음
print("\(number1) \(greeting) \(number2)")

/*
 입력 : 키보드, 음성, 터치
 저장(메모리에 저장한다.) : 변수
 처리 : 사칙연산, 문자열연산, 판별, 반복, 함수
 출력 : 화면 출력, 소리
 
 문법 요소들을 알고 있어야 한다.
 */

/* // 루프 반복문 : 같은 행위를 여러번
// i 를 1~5  에서 쓸 것이다.
// where : 1..100 까지 쓸 것인데 그 중에서(where) i 가 2로 나누어 떨어질 때 출력해랴
for i in 1...100 where i % 2 == 0 {
    print(i)
}

// _ 는 1...5 에서 꺼낸 것을 안쪽에서 쓰지 않을 때 쓰인다.
for _ in 1...5{
    print("Hello")
}

var i = 1

// while 문
while i < 6{
    print(i)
    i += 1
}

repeat {
    print("aaa")
    i += 1
} while i < 20 */

func testFunc(){
    print("test")
}

testFunc()

func testFunc2(msg:String){
    print(msg)
}

testFunc2(msg: "asd")

func testFunc3(msg:String, type:Int){
    print(msg, type)
}

testFunc3(msg : "asd", type : 3)

// _ 있으면 함수 호출할 때 타입을 쓰지 않아도 된다.
func testFunc4(_ msg:String, type:Int){
    print("sss", type)
}

func testFunc5(_ msg:String,_ type:Int){
    print(msg, type)
}

testFunc5("sss", 5)

// 메시지만 넣겠다. 매개변수에 기본값이 이미 설정되어 있다.
func testFunc6(msg:String = "test", type:Int = 77){
    print(msg, type)
}

testFunc6() // 기본값
testFunc6(msg: "test444", type: 88) // 매개변수 초기값 바꿔줌.ㄴ
