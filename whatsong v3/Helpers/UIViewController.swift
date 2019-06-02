//
//  UIViewController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 20/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

extension OpenSwipingController: UIViewControllerTransitioningDelegate    {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransition
    }
}

class RightToLeftTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        container.addSubview(toView)
        toView.frame.origin = CGPoint(x: toView.frame.width, y: 0)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            toView.frame.origin = CGPoint(x: 0, y: 0)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

class LeftToRightTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        
        container.addSubview(fromView)
        fromView.frame.origin = .zero
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            fromView.frame.origin = CGPoint(x: fromView.frame.width, y: 0)
        }, completion: { _ in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}

extension UIViewController  {
    
    func showAlert(bgColor: UIColor, text: String) {
        let statusBarHeight = (UIApplication.shared.keyWindow?.safeAreaInsets.top)!
        let offset = statusBarHeight + CGFloat(24)
        
        let popupAlert = UIView(frame: CGRect(x: 0, y: -(offset), width: view.frame.width, height: offset))
        popupAlert.backgroundColor = bgColor
        
        let labelText = UILabel()
        labelText.text = text
        labelText.textColor = .white
        labelText.font = UIFont(name: "Montserrat-Regular", size: 14)
        
        let window = (UIApplication.shared.delegate as! AppDelegate).window!
        
        window.addSubview(popupAlert)
        popupAlert.addSubview(labelText)
        labelText.centerXInSuperview()
        labelText.anchor(top: nil, leading: nil, bottom: popupAlert.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            popupAlert.transform = .init(translationX: 0, y: offset)
        }) { (_) in
            UIView.animate(withDuration: 0.4, delay: 4, options: .curveEaseIn, animations: {
                popupAlert.transform = .init(translationX: 0, y: -(offset))

            }, completion: { (_) in
                popupAlert.removeFromSuperview()
            })
        }
    }
}



