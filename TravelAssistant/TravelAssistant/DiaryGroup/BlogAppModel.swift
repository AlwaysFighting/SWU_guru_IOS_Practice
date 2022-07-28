import SwiftUI

class BlogViewModel: ObservableObject{
    @Published var posts: [Post]?
}
