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

    // Gesture variables
    @State private var lastDrag: CGFloat = 0.0
    @State private var velocity: CGFloat = 0.0
    @State private var banding: CGFloat = 4.0
    @State private var edge: Bool = false
    
    // Gesture position
    @State var position = UIScreen.main.bounds.maxY-100
    
    private var hitBox: CGFloat {
        return 0.0
    }
    
    private var top: CGFloat {
        return 0.0
    }
    
    private var middle: CGFloat {
        return UIScreen.main.bounds.maxY-400
    }
    
    private var bottom: CGFloat {
        return UIScreen.main.bounds.maxY-100
    }

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()

            withAnimation(nil) {
                content
            }
        }
        .frame(height: UIScreen.main.bounds.height)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.13), radius: 10)
        .offset(y:
            position + (edge ? dragState.translation/banding : dragState.translation)
        )
        .gesture(
            DragGesture(minimumDistance: 10, coordinateSpace: .local)
                .updating($dragState) { drag, state, translation in
                    state = .dragging(translation: drag.translation.height)
                    
                    DispatchQueue.main.async {
                        if (position + dragState.translation > bottom) || (position + dragState.translation  < top) {
                            edge = true
                        } else {
                            edge = false
                        }
                        
                        print(position, position + (edge ? dragState.translation/banding : dragState.translation), position + dragState.translation)
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
                            positionBelow = middle
                        } else {
                            positionAbove = middle
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