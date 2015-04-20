//
//  MainScreenViewController.swift
//  LorenzoSaraiva
//
//  Created by Lorenzo Saraiva on 4/16/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, UIScrollViewDelegate {


    @IBOutlet weak var scrollView: UIScrollView!
    var containerView: UIView!
    var greenView: UIView!
    var blueView: UIView!
    var redView:UIView!
    let prop: CGFloat = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.frame.size = self.view.frame.size
        
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height)
        containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size:containerSize))
        containerView.backgroundColor = UIColor.grayColor()
        scrollView.addSubview(containerView)
        containerView.center = scrollView.convertPoint(scrollView.center, fromCoordinateSpace: scrollView.superview!)
        
        // Set up your custom view hierarchy
        redView = UIView(frame: CGRect(x: 0, y: 0, width: containerView.frame.size.width * prop, height: containerView.frame.size.height * prop))
        redView.backgroundColor = UIColor.redColor();
        containerView.addSubview(redView)
        redView.center = containerView.convertPoint(containerView.center, fromCoordinateSpace: containerView.superview!)
        
        drawSecondView()
        
        greenView = UIView(frame: CGRect(x: 0, y: 0, width: blueView.frame.size.width * prop, height: blueView.frame.size.height * prop))
        greenView.backgroundColor = UIColor.greenColor();
        blueView.addSubview(greenView)
        greenView.center = blueView.convertPoint(blueView.center, fromCoordinateSpace: blueView.superview!)
        
        let greenImage:UIImageView = UIImageView(frame: CGRectMake(0, 0,greenView.frame.size.width, greenView.frame.size.height))
        greenImage.image = UIImage(named: "profile.png")
        greenView.addSubview(greenImage)
        
        // Tell the scroll view the size of the contents
        scrollView.contentSize = containerSize;
        
        // Set up the minimum & maximum zoom scales
//        let scrollViewFrame = scrollView.frame
//        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
//        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
//        let minScale = min(scaleWidth, scaleHeight)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap")
        scrollView.addGestureRecognizer(tapGesture)
        
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 70.0
        scrollView.zoomScale = 30
        
        centerScrollViewContents()
    }
    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(2, animations: {
//            self.containerView.backgroundColor = UIColor.blueColor()
//        })
    }
    
    func tap(){
        
    }
    
    func drawSecondView(){
        
        blueView = UIView(frame: CGRect(x: 0, y: 0, width: redView.frame.size.width * prop, height: redView.frame.size.height * prop))
        blueView.backgroundColor = UIColor.blueColor();
        redView.addSubview(blueView)
        blueView.center = redView.convertPoint(redView.center, fromCoordinateSpace: redView.superview!)
        
        let propSub:CGFloat = 3.7
        let diameter:CGFloat = blueView.frame.width/propSub
        
        let skillsImageView: UIView = UIView(frame: CGRectMake(diameter/6, blueView.frame.height/2 + blueView.frame.height/10, diameter, diameter))
        skillsImageView.backgroundColor = UIColor.blackColor()
        skillsImageView.layer.cornerRadius = 1
        blueView.addSubview(skillsImageView)
        
        let skillsImageViewTwo: UIView = UIView(frame: CGRectMake(diameter/3 + diameter,  blueView.frame.height/2 + blueView.frame.height/10, blueView.frame.width/propSub, blueView.frame.width/propSub))
        skillsImageViewTwo.backgroundColor = UIColor.blackColor()
        skillsImageViewTwo.layer.cornerRadius = 1
        blueView.addSubview(skillsImageViewTwo)
        
        let skillsImageViewThree: UIView = UIView(frame: CGRectMake(diameter/2 + (2 * diameter),  blueView.frame.height/2 + blueView.frame.height/10, blueView.frame.width/propSub, blueView.frame.width/propSub))
        skillsImageViewThree.backgroundColor = UIColor.blackColor()
        skillsImageViewThree.layer.cornerRadius = 1
        blueView.addSubview(skillsImageViewThree)
    
    }
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        containerView.frame = contentsFrame
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return containerView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
//        centerScrollViewContents()
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
    
