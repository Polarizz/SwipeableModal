import SwiftUI

struct ContentView : View {
    
    @State var pressed = false
    
    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Swipeable {
                    VStack(alignment: .center, spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                            
                            Capsule()
                                .fill(Color(.quaternaryLabel))
                                .frame(width: 35, height: 4)
                            
                            Spacer()
                        }
                        .padding(.top, 7)
                        .padding(.bottom, 16)
                        
                        VStack(spacing: 0) {
                            VStack(spacing: 20) {
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 1)) { pressed.toggle() }
                                }) {
                                    HStack {
                                        Spacer()
                                        
                                        Text("Test")
                                            .font(.body)
                                            .fontWeight(.medium)

                                        Spacer()
                                    }
                                    .foregroundColor(.white)
                                    .padding(.vertical, 16)
                                    .padding(.horizontal, 3)
                                    .background(pressed ? Color.blue : Color.yellow)
                                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                                }
                                
                                VStack(spacing: 20) {
                                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                                    
                                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                                    
                                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                                    
                                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                                }
                                .foregroundColor(.primary)
                                .padding(20)
                                .background(Color(.quaternarySystemFill))
                                .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                                
                                Spacer()
                            }
                            .padding(20)
                            .contentShape(Rectangle())
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            )
    }
}
