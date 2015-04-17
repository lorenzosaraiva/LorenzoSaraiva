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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var prop: CGFloat = 0.2
        
        scrollView.delegate = self
        scrollView.frame.size = self.view.frame.size
        
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height)
        containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size:containerSize))
        containerView.backgroundColor = UIColor.grayColor()
        scrollView.addSubview(containerView)
        containerView.center = scrollView.convertPoint(scrollView.center, fromCoordinateSpace: scrollView.superview!)
        
        // Set up your custom view hierarchy
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: containerView.frame.size.width * prop, height: containerView.frame.size.height * prop))
        redView.backgroundColor = UIColor.redColor();
        containerView.addSubview(redView)
        redView.center = containerView.convertPoint(containerView.center, fromCoordinateSpace: containerView.superview!)
        
        blueView = UIView(frame: CGRect(x: 0, y: 0, width: redView.frame.size.width * prop, height: redView.frame.size.height * prop))
        blueView.backgroundColor = UIColor.blueColor();
        redView.addSubview(blueView)
        blueView.center = redView.convertPoint(redView.center, fromCoordinateSpace: redView.superview!)
        
        greenView = UIView(frame: CGRect(x: 0, y: 0, width: blueView.frame.size.width * prop, height: blueView.frame.size.height * prop))
        greenView.backgroundColor = UIColor.greenColor();
        blueView.addSubview(greenView)
        greenView.center = blueView.convertPoint(blueView.center, fromCoordinateSpace: blueView.superview!)
        
        let label:UILabel = UILabel(frame: CGRectMake(blueView.frame.size.width/10, blueView.frame.size.height/10,blueView.frame.size.width/1.25, blueView.frame.size.height/1.25))
        label.backgroundColor = UIColor.yellowColor()
        blueView.addSubview(label)
        label.text = "Meu nome é Lorenzo!"
        label.textColor = UIColor.blueColor()
        
        let greenImage:UIImageView = UIImageView(frame: CGRectMake(greenView.frame.size.width/10, greenView.frame.size.height/10,greenView.frame.size.width/1.25, greenView.frame.size.height/1.25))
        greenImage.image = UIImage(named: "horse.png")
        greenView.addSubview(greenImage)
        
        // Tell the scroll view the size of the contents
        scrollView.contentSize = containerSize;
        
        // Set up the minimum & maximum zoom scales
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 70.0
        scrollView.zoomScale = 5
        
        centerScrollViewContents()
    }
    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(2, animations: {
//            self.containerView.backgroundColor = UIColor.blueColor()
//        })
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
    
