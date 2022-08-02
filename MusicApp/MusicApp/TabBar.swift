import SwiftUI

struct TabBar: View {
    
    @State var current = 2
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
            TabView(selection: $current){
                Text("라이브러리")
                    .tag(0)
                    .tabItem{
                        Image(systemName: "rectangle.stack.fill")
                        
                        Text("Libaray")
                    }
                
                Text("음악")
                    .tag(1)
                    .tabItem{
                        Image(systemName: "dot.radiowaves.left.and.right")
                        
                        Text("Music")
                    }
                
                Search()
                    .tag(2)
                    .tabItem{
                        Image(systemName: "magnifyingglass")
                        
                        Text("Search")
                    }
            }
            
            // BlurView()
            
            //Miniplayer()
        })
    }
}
