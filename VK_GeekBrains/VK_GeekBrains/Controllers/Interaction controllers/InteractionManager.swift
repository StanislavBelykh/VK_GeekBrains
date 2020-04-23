//
//  InteractionManager.swift
//  VK_GeekBrains
//
//  Created by Станислав on 21.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class InteractiveManager: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    var shouldCompleteTransition = false
    
    weak var viewController: UIViewController!
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self,
                                                       action: #selector(handleGesture(_:)))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {

        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
            let relativeTranslation = translation.x / 20
            let progress = max(0, min(1, relativeTranslation))
            
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}
