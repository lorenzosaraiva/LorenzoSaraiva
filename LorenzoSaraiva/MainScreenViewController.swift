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
    var viewHierarchy:[UIView] = []
    var imageArray:[UIImageView] = []
    var hobbiesArray:[UIImageView] = []
    var containerView: UIView!
    var greenView: UIView!
    var blueView: UIView!
    var redView:UIView!
    var currentViewIndex:Int = 0
    let prop: CGFloat = 0.01
    var isSkillViewZoomed:Bool = false
    var isHobbieViewZoomed:Bool = false
    var zoomedView: UIView!
    var hobbieZoomedView: UIView!
    var originalFrame:CGRect!
    var hobbieOriginalFrame:CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.frame.size = self.view.frame.size
        viewHierarchy.append(scrollView)
        scrollView.scrollEnabled = false

        self.view.backgroundColor = UIColor.blackColor()
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height)
        containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size:containerSize))
        containerView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(containerView)
        containerView.center = scrollView.convertPoint(scrollView.center, fromCoordinateSpace: scrollView.superview!)
        viewHierarchy.append(containerView)
        
        
        drawThirdView()
        
        drawSecondView()
        
        greenView = UIView(frame: CGRect(x: 0, y: 0, width: blueView.frame.size.width * prop, height: blueView.frame.size.height * prop))
        greenView.backgroundColor = UIColor.greenColor();
        blueView.addSubview(greenView)
        greenView.center = blueView.convertPoint(blueView.center, fromCoordinateSpace: blueView.superview!)
        viewHierarchy.append(greenView)
        
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
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "zoomIn")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        scrollView.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "zoomOut")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        scrollView.addGestureRecognizer(swipeRight)
        
        scrollView.minimumZoomScale = 0.001
        scrollView.maximumZoomScale = 1000000
        scrollView.zoomScale = 1
        currentViewIndex = 0
        
        centerScrollViewContents()
    }
    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(2, animations: {
//            self.containerView.backgroundColor = UIColor.blueColor()
//        })
    }
    
    func zoomIn(){
       
        if (currentViewIndex < viewHierarchy.count - 1){
        let rectToZoom:CGRect = containerView.convertRect(viewHierarchy[currentViewIndex + 1].frame, fromCoordinateSpace:viewHierarchy[currentViewIndex + 1].superview!)
        currentViewIndex++
        scrollView.zoomToRect(rectToZoom, animated: true)
        }

    }
    
    func zoomOut(){
        
        if (currentViewIndex > 1){
            let rectToZoom:CGRect = containerView.convertRect(viewHierarchy[currentViewIndex-1].frame, fromCoordinateSpace: viewHierarchy[currentViewIndex-1].superview!)
            currentViewIndex--
            scrollView.zoomToRect(rectToZoom, animated: true)
        }
    }

    func zoomSkillView(sender:UITapGestureRecognizer){
        
        if (isSkillViewZoomed){
            if (sender.view == zoomedView){
                
                UIView.animateWithDuration(2, animations: {() -> Void in
                    sender.view?.frame = self.originalFrame
                    
                    return
                })
                
                UIView.animateWithDuration(2, animations: {() -> Void in
                    sender.view?.alpha = 0.5
                    
                    return
                    }, completion:{finished in
                        if (self.zoomedView == self.imageArray[0])
                        {
                        self.imageArray[0].image = UIImage(named: "c")
                        }
                        if (self.zoomedView == self.imageArray[1])
                        {
                            self.imageArray[1].image = UIImage(named: "csharp")
                        }
                        if (self.zoomedView == self.imageArray[2])
                        {
                            self.imageArray[2].image = UIImage(named: "objc")
                        }
                        if (self.zoomedView == self.imageArray[3])
                        {
                            self.imageArray[3].image = UIImage(named: "swift")
                        }
                        if (self.zoomedView == self.imageArray[4])
                        {
                            self.imageArray[4].image = UIImage(named: "html")
                        }
                        if (self.zoomedView == self.imageArray[5])
                        {
                            self.imageArray[5].image = UIImage(named: "java")
                        }
                        if (self.zoomedView == self.imageArray[6])
                        {
                            self.imageArray[6].image = UIImage(named: "php")
                        }
                        if (self.zoomedView == self.imageArray[7])
                        {
                            self.imageArray[7].image = UIImage(named: "terminal")
                        }
                        if (self.zoomedView == self.imageArray[8])
                        {
                            self.imageArray[8].image = UIImage(named: "github")
                        }
                })
                isSkillViewZoomed = false
            
            }
        }
        else{
        originalFrame = sender.view?.frame
        blueView.bringSubviewToFront(sender.view!)
        UIView.animateWithDuration(1, animations: {() -> Void in
            
            sender.view?.transform = CGAffineTransformMakeRotation(0)
            return
        })
        
        UIView.animateWithDuration(2, animations: {() -> Void in
            sender.view?.frame = CGRectMake(0, (self.blueView.frame.height*12)/20, self.blueView.frame.width, (self.blueView.frame.height*7)/20)
            
            
            return
            }, completion:{finished in
                if (self.zoomedView == self.imageArray[0])
                {
                    self.imageArray[0].image = UIImage(named: "ctext")
                }
                if (self.zoomedView == self.imageArray[1])
                {
                    self.imageArray[1].image = UIImage(named: "csharptext")
                }
                if (self.zoomedView == self.imageArray[2])
                {
                    self.imageArray[2].image = UIImage(named: "objctext")
                }
                if (self.zoomedView == self.imageArray[3])
                {
                    self.imageArray[3].image = UIImage(named: "swifttext")
                }
                if (self.zoomedView == self.imageArray[4])
                {
                    self.imageArray[4].image = UIImage(named: "htmltext")
                }
                if (self.zoomedView == self.imageArray[5])
                {
                    self.imageArray[5].image = UIImage(named: "javatext")
                }
                if (self.zoomedView == self.imageArray[6])
                {
                    self.imageArray[6].image = UIImage(named: "phptext")
                }
                if (self.zoomedView == self.imageArray[7])
                {
                    self.imageArray[7].image = UIImage(named: "terminaltext")
                }
                if (self.zoomedView == self.imageArray[8])
                {
                    self.imageArray[8].image = UIImage(named: "githubtext")
                }
            })
            isSkillViewZoomed = true
            zoomedView = sender.view
            
        }
        
    }
    
    func drawSecondView(){
        
        blueView = UIView(frame: CGRect(x: 0, y: 0, width: redView.frame.size.width * prop, height: redView.frame.size.height * prop))
        redView.addSubview(blueView)
        blueView.center = redView.convertPoint(redView.center, fromCoordinateSpace: redView.superview!)
        viewHierarchy.append(blueView)
        
        
        let educationImageView:UIImageView = UIImageView(frame: CGRectMake(blueView.frame.width/10, blueView.frame.height/20, blueView.frame.width*0.8, blueView.frame.height/12))
        educationImageView.image = UIImage(named: "educationtitle")
        blueView.addSubview(educationImageView)
        
        let educationText:UIImageView = UIImageView(frame: CGRectMake(0, blueView.frame.height/8, blueView.frame.width, blueView.frame.height*0.4))
        educationText.image = UIImage(named: "educationtext")
        blueView.addSubview(educationText)
        
        let programmingSkills:UIImageView = UIImageView(frame: CGRectMake(blueView.frame.width/10, blueView.frame.height*0.52, blueView.frame.width*0.8, blueView.frame.height/15))
        programmingSkills.image = UIImage(named: "programmingskills")
        blueView.addSubview(programmingSkills)
        
        let propSub:CGFloat = 5
        let diameter:CGFloat = blueView.frame.width/propSub
        var baseY:CGFloat = blueView.frame.height/2 + blueView.frame.height/20 + diameter/4
        var baseX:CGFloat = diameter/2
        
        for var indexOut = 0; indexOut < 3; indexOut+=1{
            
            for var indexIn = 0; indexIn < 3; indexIn+=1{
        
                let skillsImageView: UIImageView = UIImageView(frame: CGRectMake(baseX, baseY, diameter, diameter))
                skillsImageView.userInteractionEnabled = true
                
                blueView.addSubview(skillsImageView)
                imageArray.append(skillsImageView)
                
                let tapGesture = UITapGestureRecognizer(target: self, action: "zoomSkillView:")
                skillsImageView.addGestureRecognizer(tapGesture)
                baseX = baseX + diameter/2 + diameter
                
            }
            baseY = baseY + diameter/4 + diameter
            baseX = diameter/2
        }
        imageArray[0].image = UIImage(named: "c")
        imageArray[1].image = UIImage(named: "csharp")
        imageArray[2].image = UIImage(named: "objc")
        imageArray[3].image = UIImage(named: "swift")
        imageArray[4].image = UIImage(named: "html")
        imageArray[5].image = UIImage(named: "java")
        imageArray[6].image = UIImage(named: "php")
        imageArray[7].image = UIImage(named: "terminal")
        imageArray[8].image = UIImage(named: "github")
      

    }
    
    func drawThirdView(){
    
        redView = UIView(frame: CGRect(x: 0, y: 0, width: containerView.frame.size.width * prop, height: containerView.frame.size.height * prop))
        redView.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(redView)
        redView.center = containerView.convertPoint(containerView.center, fromCoordinateSpace: containerView.superview!)
        viewHierarchy.append(redView)
        
        var hobbiesLabel = UIImageView(frame: CGRectMake(0, redView.frame.height/25, redView.frame.width, redView.frame.height/20))
        hobbiesLabel.image = UIImage(named: "hobbiestitle")
        redView.addSubview(hobbiesLabel)

        
        var projectsLabel = UIImageView(frame: CGRectMake(0, redView.frame.height*0.53, redView.frame.width, redView.frame.height/20))
        projectsLabel.image = UIImage(named: "projectstitle")
        redView.addSubview(projectsLabel)
        
        var firstProject = UIImageView(frame: CGRectMake(0, redView.frame.height * 0.6, redView.frame.width * 0.5 , redView.frame.height * 0.4))
        firstProject.image = UIImage(named: "orbilis")
        redView.addSubview(firstProject)
        
        var secondProject = UIImageView(frame: CGRectMake(redView.frame.width * 0.5, redView.frame.height * 0.6, redView.frame.width * 0.5 , redView.frame.height * 0.4))
        secondProject.image = UIImage(named: "orbilis")
        redView.addSubview(secondProject)
        
        
        var baseX = redView.frame.width/10
        var currentX = baseX
        var squareSide = redView.frame.width/5
        for var index = 0; index < 3; index+=1{
            
        var hobbieView = UIImageView(frame: CGRectMake(currentX, redView.frame.height/10, squareSide, squareSide))
        hobbieView.userInteractionEnabled = true
        hobbiesArray.append(hobbieView)
        redView.addSubview(hobbieView)
        let tapGesture = UITapGestureRecognizer(target: self, action: "zoomHobbie:")
        hobbieView.addGestureRecognizer(tapGesture)
        currentX = currentX + baseX + squareSide
        
        }
        baseX = redView.frame.width/5
        currentX = baseX
        var baseY =  redView.frame.height/7 + squareSide
        for var index = 0; index < 2; index+=1{
            for var subIndex = 0; subIndex < 2; subIndex+=1{
                
            var hobbieView = UIImageView(frame: CGRectMake(currentX, baseY, squareSide, squareSide))
            hobbieView.userInteractionEnabled = true
            hobbiesArray.append(hobbieView)
            redView.addSubview(hobbieView)
            let tapGesture = UITapGestureRecognizer(target: self, action: "zoomHobbie:")
            hobbieView.addGestureRecognizer(tapGesture)
            
            currentX = currentX + baseX + squareSide
            
            }
            currentX = baseX
            baseY = baseY + squareSide + redView.frame.height/30
        }
        
        hobbiesArray[0].image = UIImage(named: "games")
        hobbiesArray[1].image = UIImage(named: "cat")
        hobbiesArray[2].image = UIImage(named: "chess")
        hobbiesArray[3].image = UIImage(named: "football")
        hobbiesArray[4].image = UIImage(named: "book")
        hobbiesArray[5].image = UIImage(named: "tech")
        hobbiesArray[6].image = UIImage(named: "cinema")

        
        
    
    }
    
    func zoomHobbie(sender:UITapGestureRecognizer){
        if(isHobbieViewZoomed){
            UIView.animateWithDuration(1, animations: {() -> Void in
                
                sender.view?.frame = self.hobbieOriginalFrame
                return
                }, completion:{finished in
                    if (self.hobbieZoomedView == self.hobbiesArray[0])
                    {
                        self.hobbiesArray[0].image = UIImage(named: "games")
                    }
                    if (self.hobbieZoomedView == self.hobbiesArray[1])
                    {
                        self.hobbiesArray[1].image = UIImage(named: "cat")
                    }
                    if (self.hobbieZoomedView == self.hobbiesArray[2])
                    {
                        self.hobbiesArray[2].image = UIImage(named: "chess")
                    }
                    if (self.hobbieZoomedView == self.hobbiesArray[3])
                    {
                        self.hobbiesArray[3].image = UIImage(named: "football")
                    }
                    if (self.hobbieZoomedView == self.hobbiesArray[4])
                    {
                        self.hobbiesArray[4].image = UIImage(named: "book")
                    }
                    if (self.hobbieZoomedView == self.hobbiesArray[5])
                    {
                        self.hobbiesArray[5].image = UIImage(named: "tech")
                    }
                    if (self.hobbieZoomedView == self.hobbiesArray[6])
                    {
                        self.hobbiesArray[6].image = UIImage(named: "cinema")
                    }
            })
            isHobbieViewZoomed = false
        }else{
        hobbieOriginalFrame = sender.view?.frame
        redView.bringSubviewToFront(sender.view!)
        UIView.animateWithDuration(1, animations: {() -> Void in
            
            sender.view?.frame = CGRectMake(0, self.redView.frame.height/12
                , self.redView.frame.width, self.redView.frame.height*0.45)
            return
            }, completion:{finished in
                if (self.hobbieZoomedView == self.hobbiesArray[0])
                {
                    self.hobbiesArray[0].image = UIImage(named: "gametext")
                }
                if (self.hobbieZoomedView == self.hobbiesArray[1])
                {
                    self.hobbiesArray[1].image = UIImage(named: "cattext")
                }
                if (self.hobbieZoomedView == self.hobbiesArray[2])
                {
                    self.hobbiesArray[2].image = UIImage(named: "chesstext")
                }
                if (self.hobbieZoomedView == self.hobbiesArray[3])
                {
                    self.hobbiesArray[3].image = UIImage(named: "footballtext")
                }
                if (self.hobbieZoomedView == self.hobbiesArray[4])
                {
                    self.hobbiesArray[4].image = UIImage(named: "booktext")
                }
                if (self.hobbieZoomedView == self.hobbiesArray[5])
                {
                    self.hobbiesArray[5].image = UIImage(named: "techtext")
                }
                if (self.hobbieZoomedView == self.hobbiesArray[6])
                {
                    self.hobbiesArray[6].image = UIImage(named: "cinematext")
                }
        })
        isHobbieViewZoomed = true
        hobbieZoomedView = sender.view
    }
    
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
        centerScrollViewContents()
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
    
