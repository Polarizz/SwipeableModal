import SwiftUI

struct ContentView : View { 
    var body: some View {
        ZStack(alignment: Alignment.top) {
            MapView()
            SlideOverCard {
                LazyVStack {
                    Text("Content")
                        .font(.headline)
                    
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}
