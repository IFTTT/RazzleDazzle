
//
//  ViewController.swift
//  RazzleDazzleDemo
//
//  Created by Laura Skelton on 6/15/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit
import RazzleDazzle

class ViewController: AnimatedPagingScrollViewController {
    private let star = UIImageView(image: UIImage(named: "Star"))
    private let iftttPresents = UIImageView(image: UIImage(named: "IFTTTPresents"))
    private let razzle = UIImageView(image: UIImage(named: "Razzle"))
    private let dazzle = UIImageView(image: UIImage(named: "Dazzle"))
    
    private let musicStand = UIImageView(image: UIImage(named: "MusicStand"))
    private let musicNotes = UIImageView(image: UIImage(named: "MusicNotes"))
    private let plane = UIImageView(image: UIImage(named: "Plane"))
    private var planePathLayer = CAShapeLayer()
    private let planePathView = UIView()
    
    private let bigCloud = UIImageView(image: UIImage(named: "BigCloud"))
    private let littleCloud = UIImageView(image: UIImage(named: "LittleCloud"))
    private let sun = UIImageView(image: UIImage(named: "Sun"))
    private let iftttCloud = UIImageView(image: UIImage(named: "IFTTTCloud"))
    
    private let page2Text = UIImageView(image: UIImage(named: "Page2Text"))
    private let page3Text = UIImageView(image: UIImage(named: "Page3Text"))
    
    private var airplaneFlyingAnimation : PathPositionAnimation?
    
    override func numberOfPages() -> Int {
        // Tell the scroll view how many pages it has
        return 4
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureAnimations()
        UIApplication.shared.setStatusBarHidden(true, with: .fade)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        scaleAirplanePathToSize(scrollView.frame.size)
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: {context in
            self.scaleAirplanePathToSize(size)
            }, completion: nil)
    }
    
    private func configureViews () {
        // Add each of the views to the contentView
        contentView.addSubview(iftttPresents)
        contentView.addSubview(star)
        contentView.addSubview(razzle)
        contentView.addSubview(dazzle)
        contentView.addSubview(planePathView)
        contentView.addSubview(musicStand)
        contentView.addSubview(musicNotes)
        contentView.addSubview(bigCloud)
        contentView.addSubview(littleCloud)
        contentView.addSubview(sun)
        contentView.addSubview(iftttCloud)
        contentView.addSubview(page2Text)
        contentView.addSubview(page3Text)
    }
    
    private func configureAnimations() {
        // Configure all of the animations
        configureScrollView()
        configureIFTTTPresents()
        configureStar()
        configureRazzleDazzleLabels()
        configureMusicStand()
        configurePageText()
        configureClouds()
        configureSun()
        configureAirplane()
        animateCurrentFrame()
    }
    
    private func configureScrollView() {
        // Let's change the background color of the scroll view from dark gray to light gray to blue
        let backgroundColorAnimation = BackgroundColorAnimation(view: scrollView)
        backgroundColorAnimation[0] = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        backgroundColorAnimation[0.5] = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        backgroundColorAnimation[0.99] = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        backgroundColorAnimation[1] = UIColor(red: 0.14, green: 0.8, blue: 1, alpha: 1)
        animator.addAnimation(backgroundColorAnimation)
    }
    
    private func configureIFTTTPresents() {
        // Keep IFTTTPresents centered on pages 0 and 1, offset 20 pixels down from the top of the view
        NSLayoutConstraint(item: iftttPresents, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20).isActive = true
        keepView(iftttPresents, onPages: [0,1])
        
        // Hide IFTTTPresents when we get to page 1
        let iftttPresentsHideAnimation = HideAnimation(view: iftttPresents, hideAt: 1)
        animator.addAnimation(iftttPresentsHideAnimation)
    }
    
    private func configureStar() {
        // Center the star on the page, and keep it centered on pages 0 and 1
        let width = NSLayoutConstraint(item: star, attribute: .width, relatedBy: .lessThanOrEqual, toItem: scrollView, attribute: .width, multiplier: 1.3, constant: 0)
        let height = NSLayoutConstraint(item: star, attribute: .height, relatedBy: .lessThanOrEqual, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: star, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: scrollView, attribute: .top, multiplier: 1, constant: 30)
        let aspect = NSLayoutConstraint(item: star, attribute: .height, relatedBy: .equal, toItem: star, attribute: .width, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: star, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([width, height, top, aspect, centerY])
        keepView(star, onPages: [0,1])
        
        // Scale up the star to 7 times its original size between pages 0 and 1, with a quadratic Ease In easing function
        let starScaleAnimation = ScaleAnimation(view: star)
        starScaleAnimation.addKeyframe(0, value: 1, easing: EasingFunctionEaseInQuad)
        starScaleAnimation[1] = 10
        animator.addAnimation(starScaleAnimation)
        
        // Hide the star when we get to page 1
        let starHideAnimation = HideAnimation(view: star, hideAt: 1)
        animator.addAnimation(starHideAnimation)
    }
    
    private func configureRazzleDazzleLabels() {
        // Set the size constraints on Razzle and Dazzle
        let razzleWidth = NSLayoutConstraint(item: razzle, attribute: .width, relatedBy: .equal, toItem: star, attribute: .width, multiplier: 0.6, constant: 0)
        let razzleHeight = NSLayoutConstraint(item: razzle, attribute: .height, relatedBy: .equal, toItem: razzle, attribute: .width, multiplier: 218.0 / 576.0, constant: 0)
        let dazzleWidth = NSLayoutConstraint(item: dazzle, attribute: .width, relatedBy: .equal, toItem: star, attribute: .width, multiplier: 0.6, constant: 0)
        let dazzleHeight = NSLayoutConstraint(item: dazzle, attribute: .height, relatedBy: .equal, toItem: dazzle, attribute: .width, multiplier: 386.0 / 588.0, constant: 0)
        NSLayoutConstraint.activate([razzleWidth, razzleHeight, dazzleWidth, dazzleHeight])

        // Create the vertical position constraints for Razzle and Dazzle
        let razzleVerticalConstraint = NSLayoutConstraint(item: razzle, attribute: .centerY, relatedBy: .equal, toItem: star, attribute: .centerY, multiplier: 1, constant: 0)
        let dazzleVerticalConstraint = NSLayoutConstraint(item: dazzle, attribute: .centerY, relatedBy: .equal, toItem: star, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([razzleVerticalConstraint, dazzleVerticalConstraint])
        
        // Animate the vertical position of Razzle to go from 30 pixels above the center of the view to 200 pixels above, between pages 0 and 1
        let razzleVerticalAnimation = ConstraintConstantAnimation(superview: scrollView, constraint: razzleVerticalConstraint)
        razzleVerticalAnimation[0] = -30
        razzleVerticalAnimation[1] = -200
        animator.addAnimation(razzleVerticalAnimation)
        
        // Animate the vertical position of Razzle to go from 80 pixels below the center of the view to 260 pixels below, between pages 0 and 1
        let dazzleVerticalAnimation = ConstraintConstantAnimation(superview: scrollView, constraint: dazzleVerticalConstraint)
        dazzleVerticalAnimation[0] = 80
        dazzleVerticalAnimation[1] = 260
        animator.addAnimation(dazzleVerticalAnimation)
        
        // Center Razzle and Dazzle horizontally on the first page of the scroll view
        keepView(razzle, onPage: 0)
        keepView(dazzle, onPage: 0)
        
        // Rotate Razzle 100 degrees counter-clockwise between pages 0 and 1
        let razzleRotationAnimation = RotationAnimation(view: razzle)
        razzleRotationAnimation[0] = 0
        razzleRotationAnimation[1] = 100
        animator.addAnimation(razzleRotationAnimation)
        
        // Rotate Dazzle 100 degrees counter-clockwise between pages 0 and 1
        let dazzleRotationAnimation = RotationAnimation(view: dazzle)
        dazzleRotationAnimation[0] = 0
        dazzleRotationAnimation[1] = 100
        animator.addAnimation(dazzleRotationAnimation)
    }
    
    private func configureMusicStand() {
        // Create the vertical position constraint for the music stand
        let musicStandVerticalConstraint = NSLayoutConstraint(item: musicStand, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0)
        let standTop = NSLayoutConstraint(item: musicStand, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: scrollView, attribute: .top, multiplier: 1, constant: 40)
        let standWidth = NSLayoutConstraint(item: musicStand, attribute: .width, relatedBy: .lessThanOrEqual, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)
        let standAspect = NSLayoutConstraint(item: musicStand, attribute: .height, relatedBy: .equal, toItem: musicStand, attribute: .width, multiplier: 1184.0 / 750.0, constant: 0)
        let standHeight = NSLayoutConstraint(item: musicStand, attribute: .height, relatedBy: .lessThanOrEqual, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([musicStandVerticalConstraint, standTop, standWidth, standAspect, standHeight])
        
        // Keep the right side of the music stand at the right edge of pages 1 and 2
        keepView(musicStand, onPages: [1,2], withAttribute: .right)
        
        // Animate the music stand's bottom offset from the view to go from being offset 0 times to 1 time the height of the contentView between pages 1 and 2,
        // with a cubic Ease Out easing function
        let musicStandVerticalAnimation = ConstraintMultiplierAnimation(superview: scrollView, constraint: musicStandVerticalConstraint, attribute: .height, referenceView: contentView)
        musicStandVerticalAnimation.addKeyframe(1, value: 0, easing: EasingFunctionEaseOutCubic)
        musicStandVerticalAnimation[2] = 1
        animator.addAnimation(musicStandVerticalAnimation)
        
        // Lay out the music notes
        let notesWidth = NSLayoutConstraint(item: musicNotes, attribute: .width, relatedBy: .equal, toItem: musicStand, attribute: .width, multiplier: 1, constant: 0)
        let notesHeight = NSLayoutConstraint(item: musicNotes, attribute: .height, relatedBy: .equal, toItem: musicStand, attribute: .height, multiplier: 1, constant: 0)
        let notesCenterY = NSLayoutConstraint(item: musicNotes, attribute: .centerY, relatedBy: .equal, toItem: musicStand, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([notesWidth, notesHeight, notesCenterY])
      
        // Move the music notes in quickly from the right when we change from page 0.5 to 1, and keep them centered on pages 1 and 2
        keepView(musicNotes, onPages: [2, 1, 2], atTimes: [0.5, 1, 2], withAttribute: .right)
    }
    
    private func configurePageText() {
        // Keep the page2Text slightly above center on page 2
        NSLayoutConstraint(item: page2Text, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .centerY, multiplier: 0.95, constant: 0).isActive = true
        keepView(page2Text, onPage: 2)
        
        // Keep the page3Text centered on page 3
        NSLayoutConstraint(item: page3Text, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        keepView(page3Text, onPage: 3)
    }
    
    private func configureClouds() {
        // Lay out the big cloud
        let bigCloudVerticalConstraint = NSLayoutConstraint(item: bigCloud, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0)
        let bigCloudWidth = NSLayoutConstraint(item: bigCloud, attribute: .width, relatedBy: .lessThanOrEqual, toItem: scrollView, attribute: .width, multiplier: 0.78, constant: 0)
        let bigCloudHeight = NSLayoutConstraint(item: bigCloud, attribute: .height, relatedBy: .lessThanOrEqual, toItem: scrollView, attribute: .height, multiplier: 0.2, constant: 0)
        let bigCloudAspect = NSLayoutConstraint(item: bigCloud, attribute: .height, relatedBy: .equal, toItem: bigCloud, attribute: .width, multiplier: 0.45, constant: 0)
        NSLayoutConstraint.activate([bigCloudVerticalConstraint, bigCloudWidth, bigCloudHeight, bigCloudAspect])
        
        // Keep the big cloud slightly to the right on pages 1 and 2, and zoom it out to the left between pages 2 and 3
        keepView(bigCloud, onPages: [1.35, 2.35, 1.8], atTimes: [1, 2, 3])
        
        // Move the big cloud from above the view down to near the top of the view between pages 1 and 2
        let bigCloudVerticalAnimation = ConstraintMultiplierAnimation(superview: scrollView, constraint: bigCloudVerticalConstraint, attribute: .height, referenceView: scrollView)
        bigCloudVerticalAnimation[1] = -0.2
        bigCloudVerticalAnimation[2] = 0.2
        animator.addAnimation(bigCloudVerticalAnimation)
        
        // Lay out the little cloud
        let littleCloudBottom = NSLayoutConstraint(item: littleCloud, attribute: .bottom, relatedBy: .equal, toItem: bigCloud, attribute: .top, multiplier: 1, constant: 20)
        let littleCloudWidth = NSLayoutConstraint(item: littleCloud, attribute: .width, relatedBy: .equal, toItem: bigCloud, attribute: .height, multiplier: 1, constant: 0)
        let littleCloudAspect = NSLayoutConstraint(item: littleCloud, attribute: .height, relatedBy: .equal, toItem: littleCloud, attribute: .width, multiplier: 0.5, constant: 0)
        NSLayoutConstraint.activate([littleCloudBottom, littleCloudWidth, littleCloudAspect])
        
        // Keep the little cloud slightly to the left on pages 1 and 2
        keepView(littleCloud, onPages: [0.75, 1.75], atTimes: [1, 2])
        
        // Lay out the IFTTT cloud on the bottom half of the view
        NSLayoutConstraint(item: iftttCloud, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .centerY, multiplier: 1.5, constant: 0).isActive = true
        
        // Zoom in the IFTTT cloud from the right between pages 2 and 3
        keepView(iftttCloud, onPages: [3.5, 3], atTimes: [2, 3])
    }
    
    private func configureSun() {
        let sunVerticalConstraint = NSLayoutConstraint(item: sun, attribute: .centerY, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0)
        sunVerticalConstraint.isActive = true
        
        // Move the sun from the right side to the left side between pages 2.5 and 3
        keepView(sun, onPages: [2.8, 2.6], atTimes: [2.5, 3])
        
        // Move the sun from above the view offscreen to near the top of the view
        let sunVerticalAnimation = ConstraintConstantAnimation(superview: scrollView, constraint: sunVerticalConstraint)
        sunVerticalAnimation[2] = -200
        sunVerticalAnimation[3] = 20
        animator.addAnimation(sunVerticalAnimation)
    }
    
    private func configureAirplane() {
        // Set up the view that contains the airplane view and its dashed line path view
        planePathLayer = airplanePathLayer()
        planePathView.layer.addSublayer(planePathLayer)
        planePathView.addSubview(plane)
        planePathView.translatesAutoresizingMaskIntoConstraints = false
        plane.translatesAutoresizingMaskIntoConstraints = false
        let planeBottom = NSLayoutConstraint(item: plane, attribute: .bottom, relatedBy: .equal, toItem: planePathView, attribute: .centerY, multiplier: 1, constant: 0)
        let planeRight = NSLayoutConstraint(item: plane, attribute: .right, relatedBy: .equal, toItem: planePathView, attribute: .centerX, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([planeBottom, planeRight])
        
        let planePathBottom = NSLayoutConstraint(item: planePathView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 40)
        let planePathWidth = NSLayoutConstraint(item: planePathView, attribute: .width, relatedBy: .equal, toItem: plane, attribute: .width, multiplier: 1, constant: 0)
        let planePathHeight = NSLayoutConstraint(item: planePathView, attribute: .height, relatedBy: .equal, toItem: plane, attribute: .height, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([planePathBottom, planePathWidth, planePathHeight])
        
        // Keep the left edge of the planePathView at the center of pages 1 and 2
        keepView(planePathView, onPages: [1.5, 2.5], atTimes: [1, 2], withAttribute: .left)
        
        // Fly the plane along the path
        airplaneFlyingAnimation = PathPositionAnimation(view: plane, path: planePathLayer.path)
        airplaneFlyingAnimation![1] = 0
        airplaneFlyingAnimation![2] = 1
        animator.addAnimation(airplaneFlyingAnimation!)
        
        // Change the stroke end of the dashed line airplane path to match the plane's current position
        let planePathAnimation = LayerStrokeEndAnimation(layer: planePathLayer)
        planePathAnimation[1] = 0
        planePathAnimation[2] = 1
        animator.addAnimation(planePathAnimation)
        
        // Fade the plane path view in after page 1 and fade it out again after page 2.5
        let planeAlphaAnimation = AlphaAnimation(view: planePathView)
        planeAlphaAnimation[1.06] = 0
        planeAlphaAnimation[1.08] = 1
        planeAlphaAnimation[2.5] = 1
        planeAlphaAnimation[3] = 0
        animator.addAnimation(planeAlphaAnimation)
    }
    
    private func airplanePath() -> CGPath {
        // Create a bezier path for the airplane to fly along
        let airplanePath = UIBezierPath()
        airplanePath.move(to: CGPoint(x: 120, y: 20))
        airplanePath.addCurve(to: CGPoint(x: 40, y: -130), controlPoint1: CGPoint(x: 120, y: 20), controlPoint2: CGPoint(x: 140, y: -50))
        airplanePath.addCurve(to: CGPoint(x: 30, y: -430), controlPoint1: CGPoint(x: -60, y: -210), controlPoint2: CGPoint(x: -320, y: -430))
        airplanePath.addCurve(to: CGPoint(x: -210, y: -190), controlPoint1: CGPoint(x: 320, y: -430), controlPoint2: CGPoint(x: 130, y: -190))
        return airplanePath.cgPath
    }
    
    private func airplanePathLayer() -> CAShapeLayer {
        // Create a shape layer to draw the airplane's path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = airplanePath()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineDashPattern = [20, 20]
        shapeLayer.lineWidth = 4
        shapeLayer.miterLimit = 4
        shapeLayer.fillColor = nil
        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        return shapeLayer
    }
    
    private func scaleAirplanePathToSize(_ pageSize: CGSize) {
        // Scale the airplane path to the given page size
        let scaleSize = CGSize(
            width: pageSize.width / 375.0,
            height: pageSize.height / 667.0)
        
        var scaleTransform = CGAffineTransform(scaleX: scaleSize.width, y: scaleSize.height)
        let scaledPath = airplanePath().copy(using: &scaleTransform)
        planePathLayer.path = scaledPath
        
        if let planeAnimation = airplaneFlyingAnimation {
            planeAnimation.path = scaledPath
        }
    }
}
