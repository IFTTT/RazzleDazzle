//
//  AnimatedPagingScrollViewController.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/16/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
View controller for creating scrolling app intros. Set animation times based on the page number, and this view controller handles calling `animate:` on the `animator`.
*/
public class AnimatedPagingScrollViewController : UIViewController, UIScrollViewDelegate {
    public let scrollView = UIScrollView()
    public let contentView = UIView()
    public var animator = Animator()
    private var scrollViewPageConstraintAnimations = [ScrollViewPageConstraintAnimation]()
    public var pageWidth : CGFloat {
        get {
            return CGRectGetWidth(scrollView.frame)
        }
    }
    private var _pageOffset: CGFloat = 0
    public var pageOffset : CGFloat {
        get {
            return _pageOffset
        }
        set {
            if newValue < 0 || newValue > CGFloat(numberOfPages() - 1) {
                return
            }
            
            _pageOffset = newValue
            scrollView.contentOffset = CGPoint(x: pageWidth * _pageOffset, y: 0)
            animateCurrentFrame()
        }
    }
    
    public func numberOfPages() -> Int {
        return 2
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSizeMake(CGFloat(numberOfPages()) * CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView" : scrollView]))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView" : scrollView]))
      
        let scrollViewLeft = NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: 0)
        let scrollViewRight = NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1, constant: 0)
        let scrollViewTop = NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 0)
        let scrollViewBottom = NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1, constant: 0)
      
        NSLayoutConstraint.activateConstraints([scrollViewLeft, scrollViewRight, scrollViewTop, scrollViewBottom])
      
        let contentViewWidth = NSLayoutConstraint(item: contentView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: CGFloat(numberOfPages()), constant: 0)
        let contentViewHeight = NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0)
      
        NSLayoutConstraint.activateConstraints([contentViewWidth, contentViewHeight])
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        pageOffset = _pageOffset
        animateCurrentFrame()
    }
    
    public override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        let newPageWidth = size.width
        for animation in scrollViewPageConstraintAnimations {
            animation.pageWidth = newPageWidth
        }
        let futurePixelOffset = pageOffset * newPageWidth
        coordinator.animateAlongsideTransition({context in
            self.animateCurrentFrame()
            self.scrollView.contentOffset.x = futurePixelOffset
            }, completion: nil)
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        updatePageOffset()
        animateCurrentFrame()
    }
    
    private func updatePageOffset() {
        if pageWidth > 0 {
            let currentOffset = scrollView.contentOffset.x
            _pageOffset = currentOffset / pageWidth
        } else {
            _pageOffset = 0
        }
    }
    
    public func animateCurrentFrame () {
        animator.animate(pageOffset)
    }
    
    public func keepView(view: UIView, onPage page: CGFloat) {
        keepView(view, onPage: page, withAttribute: .CenterX)
    }
    
    public func keepView(view: UIView, onPage page: CGFloat, withAttribute attribute: HorizontalPositionAttribute) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: layoutAttributeFromRazAttribute(attribute), relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: multiplierForPage(page, attribute: attribute), constant: 0).active = true
    }
    
    public func keepView(view: UIView, onPages pages: [CGFloat]) {
        keepView(view, onPages: pages, atTimes: pages)
    }
    
    public func keepView(view: UIView, onPages pages: [CGFloat], withAttribute attribute: HorizontalPositionAttribute) {
        keepView(view, onPages: pages, atTimes: pages, withAttribute: attribute)
    }

    public func keepView(view: UIView, onPages pages: [CGFloat], atTimes times: [CGFloat]) {
        keepView(view, onPages: pages, atTimes: times, withAttribute: .CenterX)
    }
    
    public func keepView(view: UIView, onPages pages: [CGFloat], atTimes times: [CGFloat], withAttribute attribute: HorizontalPositionAttribute) {
        assert(pages.count == times.count, "Make sure you set a time for each position.")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let xPositionConstraint = NSLayoutConstraint(item: view, attribute: layoutAttributeFromRazAttribute(attribute), relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: 0)
        xPositionConstraint.active = true
        let xPositionAnimation = ScrollViewPageConstraintAnimation(superview: contentView, constraint: xPositionConstraint, pageWidth: pageWidth, attribute: attribute)
        for (index, page) in pages.enumerate() {
            xPositionAnimation[times[index]] = page
        }
        animator.addAnimation(xPositionAnimation)
        scrollViewPageConstraintAnimations.append(xPositionAnimation)
    }
    
    public func centerXMultiplierForPage(page: CGFloat) -> CGFloat {
        return multiplierForPage(page, attribute: .CenterX)
    }
    
    public func leftMultiplierForPage(page: CGFloat) -> CGFloat {
        return multiplierForPage(page, attribute: .Left)
    }
    
    public func rightMultiplierForPage(page: CGFloat) -> CGFloat {
        return multiplierForPage(page, attribute: .Right)
    }
    
    public func multiplierForPage(page: CGFloat, attribute: HorizontalPositionAttribute) -> CGFloat {
        var offset : CGFloat
        switch attribute {
        case .CenterX:
            offset = 0.5
        case .Left:
            offset = 0
        case .Right:
            offset = 1
        }
        return 2.0 * (offset + page) / CGFloat(numberOfPages())
    }
    
    public func layoutAttributeFromRazAttribute(razAttribute: HorizontalPositionAttribute) -> NSLayoutAttribute {
        var attribute : NSLayoutAttribute
        switch razAttribute {
        case .CenterX:
            attribute = .CenterX
        case .Left:
            attribute = .Left
        case .Right:
            attribute = .Right
        }
        return attribute
    }
}

