import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem(){
                        Image(systemName: "house")
                        Text("홈")
             }
    
            ExpenseView()
                .tabItem(){
                        Image(systemName: "dollarsign.circle")
                        Text("지출 내역")
                }
            
            CalendarView()
                .tabItem(){
                        Image(systemName: "calendar.badge.clock")
                        Text("할 일")
            }
            
            DiaryView()
                .tabItem(){
                        Image(systemName: "book")
                        Text("일기장")
            }
            
            UserView()
                .tabItem(){
                        Image(systemName: "person.circle")
                        Text("마이페이지")
            }
         }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
