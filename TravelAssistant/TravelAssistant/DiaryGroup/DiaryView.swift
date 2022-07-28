import SwiftUI

struct DiaryView: View {
    @StateObject var blogData = BlogViewModel()
    
    var body: some View {
        VStack{
            
            if let posts = blogData.posts{
               
                // No posts..
                if posts.isEmpty{
                    (
                        Text(Image(systemName: "rectangle.and.pencil.and.ellipsis"))
                        +
                        Text("하루 일과를 작성해보세요 :)")
                    )
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                }else{
                    
                    List(posts){ post in
                        
                        CardView(post: post)
                    }
                    .listStyle(.insetGrouped)
                }
              
            }else{
                ProgressView()
            }
        }
        .navigationTitle("나의 일상을 블로그처럼 적어보세요")
       // .frame(maxWidth)
    }
    
    @ViewBuilder
    func CardView(post: Post)->some View{
        VStack(alignment: .leading, spacing: 12){
            
            Text(post.title)
                .fontWeight(.bold)
            
            Text("작성자 :  \(post.author)")
                .font(.callout)
                .foregroundColor(.gray)
            
            Text("작성자 :  \(post.date.dateValue().formatted(date: .numeric, time: .shortened))")
                .font(.caption.bold())
                .foregroundColor(.gray)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}
