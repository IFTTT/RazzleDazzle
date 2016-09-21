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
open class AnimatedPagingScrollViewController : UIViewController, UIScrollViewDelegate {
    open let scrollView = UIScrollView()
    open let contentView = UIView()
    open var animator = Animator()
    fileprivate var scrollViewPageConstraintAnimations = [ScrollViewPageConstraintAnimation]()
    open var pageWidth : CGFloat {
        get {
            return scrollView.frame.width
        }
    }
    open var pageOffset : CGFloat {
        get {
            var currentOffset = scrollView.contentOffset.x
            if pageWidth > 0 {
                currentOffset = currentOffset / pageWidth
            }
            return currentOffset
        }
    }
    
    open func numberOfPages() -> Int {
        return 2
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: CGFloat(numberOfPages()) * view.frame.width, height: view.frame.height)
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView" : scrollView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView" : scrollView]))
      
        let scrollViewLeft = NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0)
        let scrollViewRight = NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0)
        let scrollViewTop = NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0)
        let scrollViewBottom = NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
      
        NSLayoutConstraint.activate([scrollViewLeft, scrollViewRight, scrollViewTop, scrollViewBottom])
      
        let contentViewWidth = NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: CGFloat(numberOfPages()), constant: 0)
        let contentViewHeight = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
      
        NSLayoutConstraint.activate([contentViewWidth, contentViewHeight])
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateCurrentFrame()
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let newPageWidth = size.width
        for animation in scrollViewPageConstraintAnimations {
            animation.pageWidth = newPageWidth
        }
        let futurePixelOffset = pageOffset * newPageWidth
        coordinator.animate(alongsideTransition: {context in
            self.animateCurrentFrame()
            self.scrollView.contentOffset.x = futurePixelOffset
            }, completion: nil)
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        animateCurrentFrame()
    }
    
    open func animateCurrentFrame () {
        animator.animate(pageOffset)
    }
    
    open func keepView(_ view: UIView, onPage page: CGFloat) {
        keepView(view, onPage: page, withAttribute: .centerX)
    }
    
    open func keepView(_ view: UIView, onPage page: CGFloat, withAttribute attribute: HorizontalPositionAttribute) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: layoutAttributeFromRazAttribute(attribute), relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: multiplierForPage(page, attribute: attribute), constant: 0).isActive = true
    }
    
    open func keepView(_ view: UIView, onPages pages: [CGFloat]) {
        keepView(view, onPages: pages, atTimes: pages)
    }
    
    open func keepView(_ view: UIView, onPages pages: [CGFloat], withAttribute attribute: HorizontalPositionAttribute) {
        keepView(view, onPages: pages, atTimes: pages, withAttribute: attribute)
    }

    open func keepView(_ view: UIView, onPages pages: [CGFloat], atTimes times: [CGFloat]) {
        keepView(view, onPages: pages, atTimes: times, withAttribute: .centerX)
    }
    
    open func keepView(_ view: UIView, onPages pages: [CGFloat], atTimes times: [CGFloat], withAttribute attribute: HorizontalPositionAttribute) {
        assert(pages.count == times.count, "Make sure you set a time for each position.")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let xPositionConstraint = NSLayoutConstraint(item: view, attribute: layoutAttributeFromRazAttribute(attribute), relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0)
        xPositionConstraint.isActive = true
        let xPositionAnimation = ScrollViewPageConstraintAnimation(superview: contentView, constraint: xPositionConstraint, pageWidth: pageWidth, attribute: attribute)
        for (index, page) in pages.enumerated() {
            xPositionAnimation[times[index]] = page
        }
        animator.addAnimation(xPositionAnimation)
        scrollViewPageConstraintAnimations.append(xPositionAnimation)
    }
    
    open func centerXMultiplierForPage(_ page: CGFloat) -> CGFloat {
        return multiplierForPage(page, attribute: .centerX)
    }
    
    open func leftMultiplierForPage(_ page: CGFloat) -> CGFloat {
        return multiplierForPage(page, attribute: .left)
    }
    
    open func rightMultiplierForPage(_ page: CGFloat) -> CGFloat {
        return multiplierForPage(page, attribute: .right)
    }
    
    open func multiplierForPage(_ page: CGFloat, attribute: HorizontalPositionAttribute) -> CGFloat {
        var offset : CGFloat
        switch attribute {
        case .centerX:
            offset = 0.5
        case .left:
            offset = 0
        case .right:
            offset = 1
        }
        return 2.0 * (offset + page) / CGFloat(numberOfPages())
    }
    
    open func layoutAttributeFromRazAttribute(_ razAttribute: HorizontalPositionAttribute) -> NSLayoutAttribute {
        var attribute : NSLayoutAttribute
        switch razAttribute {
        case .centerX:
            attribute = .centerX
        case .left:
            attribute = .left
        case .right:
            attribute = .right
        }
        return attribute
    }
}

