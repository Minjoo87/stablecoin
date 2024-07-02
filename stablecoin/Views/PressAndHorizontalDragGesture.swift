import SwiftUI

/// A proxy view for press and horizontal drag detection.
struct PressAndHorizontalDragGestureView: UIViewRepresentable {
    let minimumPressDuration: Double = 0.4
    let translationThreshold: CGFloat = 10
    var onBegan: ((Value) -> Void)? = nil
    var onChanged: ((Value) -> Void)? = nil
    var onEnded: ((Value) -> Void)? = nil
    
    struct Value {
        /// The location of the current event.
        let location: CGPoint
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var parent: PressAndHorizontalDragGestureView
        
        var isLongPressActivated: Bool = false
        var isDragActivated: Bool = false
        
        var longPress: UILongPressGestureRecognizer!
        var pan: UIPanGestureRecognizer!
        
        init(_ parent: PressAndHorizontalDragGestureView) {
            self.parent = parent
        }

        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            // Only on horizontal drag
            if gestureRecognizer == pan {
                let v = pan.velocity(in: pan.view!)
                return abs(v.x) > abs(v.y)
            } else if gestureRecognizer == longPress {
                isLongPressActivated = true
                return true
            } else {
                fatalError("Unknown gesture recognizer")
            }
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            // Only this combo works together
            return (gestureRecognizer == pan && otherGestureRecognizer == longPress)
                || (gestureRecognizer == longPress && otherGestureRecognizer == pan)
        }

        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return otherGestureRecognizer != pan && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
        }
        
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let view = gesture.view else { return }
            
            let translation = gesture.translation(in: view)
            if abs(translation.x) > parent.translationThreshold {
                isDragActivated = true
                parent.onBegan?(.init(location: gesture.location(in: view)))
            }
            
            if isLongPressActivated || isDragActivated {
                switch gesture.state {
                case .changed:
                    parent.onChanged?(.init(location: gesture.location(in: view)))
                case .ended:
                    isDragActivated = false
                    isLongPressActivated = false
                    parent.onEnded?(.init(location: gesture.location(in: view)))
                default:
                    break
                }
            }
        }
        
        @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
            guard let view = gesture.view else { return }
            
            switch gesture.state {
            case .began:
                isLongPressActivated = true
                parent.onBegan?(.init(location: gesture.location(in: view)))
            case .ended:
                isLongPressActivated = false
                isDragActivated = false
                parent.onEnded?(.init(location: gesture.location(in: view)))
            default: break
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress))
        longPress.minimumPressDuration = minimumPressDuration
        longPress.delegate = context.coordinator
        
        view.addGestureRecognizer(longPress)
        context.coordinator.longPress = longPress
        
        let pan = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan))
        pan.delegate = context.coordinator
        
        view.addGestureRecognizer(pan)
        context.coordinator.pan = pan
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.parent = self
    }
}
