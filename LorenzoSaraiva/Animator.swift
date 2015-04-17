//
//  Animator.swift
//  LorenzoSaraiva
//
//  Created by Lorenzo Saraiva on 4/16/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration    = 5.0
    var presenting  = true
    var originFrame = CGRect.zeroRect
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning)-> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        let toView =
        transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        
        
        if presenting {
            herbView.alpha = 0.0
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(herbView)
        
        UIView.animateWithDuration(duration, delay:1.0,
            options: nil,
            animations: {
                herbView.alpha = 1
                
            }, completion:{_ in
                transitionContext.completeTransition(true)
        })

    }
}
