//
//  MagicPresent.swift
//  MagicPresent
//
//  Created by KhuongPham on 10/26/17.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import UIKit

enum PresentationPosition {
    case bottom
    case center
}

open class MagicPresent: UIPresentationController {
    private var dimmingView: UIView?
    private var presentationWrappingView: UIView?
    
    var animationDuration: Double = 0.2
    var position: PresentationPosition = .bottom
    var shadowEnabled = true
    var cornerRadius: CGFloat = 0
    var dismissEnabled = true
    var shadowAlpha: CGFloat = 0.5
    
    
    override open var presentedView: UIView? {
        return presentationWrappingView
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
        presentedViewController.transitioningDelegate = self
    }
    
    
    override open func presentationTransitionWillBegin() {
        let presentedViewControllerView = super.presentedView!
        let presentationWrapperView = UIView(frame: self.frameOfPresentedViewInContainerView)
        
        presentedViewControllerView.translatesAutoresizingMaskIntoConstraints = true
        presentedViewControllerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentedViewControllerView.frame = presentationWrapperView.bounds
        presentedViewControllerView.clipsToBounds = true
        presentedViewControllerView.layer.cornerRadius = cornerRadius
        
        if shadowEnabled {
            presentationWrapperView.layer.shadowOpacity = 0.5
            presentationWrapperView.layer.shadowRadius = 5
            presentationWrapperView.layer.shadowOffset = CGSize(width:0, height:-3)
        }
        
        presentationWrapperView.addSubview(presentedViewControllerView)
        self.presentationWrappingView = presentationWrapperView
        
        let dimmingView = UIView(frame: self.containerView?.bounds ?? .zero)
        dimmingView.backgroundColor = UIColor.black
        dimmingView.isOpaque = false
        dimmingView.translatesAutoresizingMaskIntoConstraints = true
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(dimmingViewTapped)))
        self.dimmingView = dimmingView
        self.containerView?.addSubview(dimmingView)
        
        
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        
        self.dimmingView?.alpha = 0
        transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView?.alpha = self?.shadowAlpha ?? 0
            }, completion: nil)
    }
    
    override open func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }
    
    
    override open func dismissalTransitionWillBegin() {
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        
        transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView?.alpha = 0
            }, completion: nil)
    }
    
    
    override open func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }
    
    override open func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if container === self.presentedViewController {
            self.containerView?.setNeedsLayout()
        }
    }
    
    override open func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if container === self.presentedViewController {
            return (container as! UIViewController).preferredContentSize
        }
        return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
    }
    
    override open var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = self.containerView else { return .zero }
        
        let size = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerView.bounds.size)
        
        switch position {
        case .center:
            let x = containerView.frame.midX - size.width / 2
            let y = containerView.frame.midY - size.height / 2
            
            let toInitFrame = CGRect(origin: CGPoint(x:x, y:y), size: size)
            
            return toInitFrame
            
        case .bottom:
            let x = containerView.frame.midX - size.width / 2
            let y = containerView.frame.maxY
            let toInitFrame = CGRect(origin: CGPoint(x:x, y:y), size: size)
            let toFinalFrame = toInitFrame.offsetBy(dx: 0, dy: -size.height)
            
            return toFinalFrame
        }
    }
    
    override open func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        dimmingView?.frame = containerView?.bounds ?? .zero
        presentationWrappingView?.frame = self.frameOfPresentedViewInContainerView
    }
    
    @objc private func dimmingViewTapped() {
        if dismissEnabled {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension MagicPresent: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionContext?.isAnimated ?? false ? animationDuration : 0
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let isPresenting = (fromVC == self.presentingViewController)
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        if (isPresenting) {
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            
            containerView.addSubview(toView!)
            
            let size = toVC.preferredContentSize
            
            switch position {
            case .center:
                let x = containerView.frame.midX - size.width / 2
                let y = containerView.frame.midY - size.height / 2
                
                let toInitFrame = CGRect(origin: CGPoint(x:x, y:y), size: size)
                
                toView?.frame = toInitFrame
                toView?.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
                
                UIView.animate(withDuration: transitionDuration, animations: {
                    toView?.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                }, completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
                
            case .bottom:
                let x = containerView.frame.midX - size.width / 2
                let y = containerView.frame.maxY
                let toInitFrame = CGRect(origin: CGPoint(x:x, y:y), size: size)
                let toFinalFrame = toInitFrame.offsetBy(dx: 0, dy: -size.height)
                
                toView?.frame = toInitFrame
                
                UIView.animate(withDuration: transitionDuration, animations: {
                    toView?.frame = toFinalFrame
                }, completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        } else {
            guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
            
            switch position {
            case .center:
                UIView.animate(withDuration: transitionDuration, animations: {
                    fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    fromView.alpha = 0
                }, completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
                
            case .bottom:
                let fromFinalFrame: CGRect = fromView.frame.offsetBy(dx: 0, dy: fromView.frame.height)
                
                UIView.animate(withDuration: transitionDuration, animations: {
                    fromView.frame = fromFinalFrame
                }, completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
    }
}

extension MagicPresent: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
