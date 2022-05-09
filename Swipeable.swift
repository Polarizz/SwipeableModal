//
//  Swipeable.swift
//  SwipeableModal
//
//  Created by Polarizz on 5/6/22.
//

import SwiftUI

struct Swipeable<Content: View>: View {
    
    let content: Content
    
    @GestureState private var dragState = DragState.inactive
    
    // Gesture position
    @State var position = UIScreen.main.bounds.maxY - 200
    @State var fullTop = false
    
    private var top: CGFloat {
        return 0.0
    }
    
    private var middle: CGFloat {
        return UIScreen.main.bounds.maxY/2
    }
    
    private var bottom: CGFloat {
        return UIScreen.main.bounds.maxY - 200
    }
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            withAnimation(nil) {
                content
                    .padding(.top, fullTop ? UIApplication.shared.windows[0].safeAreaInsets.top : 0)
            }
            
            Spacer()
        }
        .frame(minHeight: UIScreen.main.bounds.height)
        .background(
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
        )
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.13), radius: 10)
        .offset(
            y:
                position + dragState.translation
        )
        .highPriorityGesture(
            DragGesture(minimumDistance: 10, coordinateSpace: .local)
                .updating($dragState) { drag, state, translation in
                    state = .dragging(translation: drag.translation.height)
                    
                    DispatchQueue.main.async {
                        if (position + dragState.translation) <= 0 {
                            fullTop = true
                        } else {
                            fullTop = false
                        }
                        
                        //                       if (position + dragState.translation) >= bottom {
                        //                           popup = false
                        //                       } else {
                        //                           popup = true
                        //                       }
                        
                        print(position + dragState.translation)
                    }
                }
                .onEnded { drag in
                    DispatchQueue.main.async {
                        let verticalDirection = drag.predictedEndLocation.y - drag.location.y
                        let cardTopEdgeLocation = position + drag.translation.height
                        let positionAbove: CGFloat
                        let positionBelow: CGFloat
                        let closestPosition: CGFloat
                        
                        if cardTopEdgeLocation <= middle {
                            positionAbove = top
                            positionBelow = bottom
                        } else {
                            positionAbove = top
                            positionBelow = bottom
                        }
                        
                        if (cardTopEdgeLocation - positionAbove) < (positionBelow - cardTopEdgeLocation) {
                            closestPosition = positionAbove
                        } else {
                            closestPosition = positionBelow
                        }
                        
                        if verticalDirection > 0 {
                            position = positionBelow
                        } else if verticalDirection < 0 {
                            position = positionAbove
                        } else {
                            position = closestPosition
                        }
                        
                        if position == top {
                            fullTop = true
                        } else {
                            fullTop = false
                        }
                    }
                }
        )
        .animation(dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
    }
}


enum DragState {
    
    case inactive
    case dragging(translation: CGFloat)
    
    var translation: CGFloat {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

// UIApplication.shared.windows[0].safeAreaInsets.top
