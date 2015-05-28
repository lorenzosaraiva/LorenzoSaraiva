//
//  MainScreenViewController.swift
//  LorenzoSaraiva
//
//  Created by Lorenzo Saraiva on 4/16/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

import UIKit
import MapKit

class MainScreenViewController: UIViewController, UIScrollViewDelegate, MKMapViewDelegate {


    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Main control variables
    
    var viewHierarchy:[UIView] = []
    var currentViewIndex:Int = 0
    let font = UIFont(name: "Euphemia UCAS", size: 16)
    let prop: CGFloat = 0.01
    
    
    //MARK: - Presentation and MapView variables
    
    var presentationMapView: UIView!
    var blackView:UIView!
    
    //MARK: - Education and Skills view variables
    
    var skillsArray:[UIImageView] = []
    var educationSkillView: UIView!
    var originalFrame:CGRect!
    var isSkillViewZoomed:Bool = false
    var skillZoomedView: UIView!


    //MARK: - Hobbies and Projects view variables
    
    
    var hobbiesProjectsView:UIView!
    
    var isHobbieViewZoomed:Bool = false
    var hobbieZoomedView: UIView!
    var hobbieOriginalFrame:CGRect!
    var hobbiesArray:[UIImageView] = []
    
    var isProjectViewZoomed:Bool = false
    var projectZoomedView:UIView!
    var projectOriginalFrame:CGRect!
    var projectArray:[UIImageView] = []
    
    //MARK: - Profile view variables
    
    var profileView: UIImageView!
    
    

    //MARK: - Default functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawBlackView()
        
        setScrollView()
        
        drawPresentationView()
        
        drawEducationSkillView()

        drawHobbiesEducationView()
        
        drawProfileView()
        
        createGestureRecognizers()
        
        centerScrollViewContents()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        scrollView.setZoomScale(0.003, animated: false)
        blackView.removeFromSuperview()

    }
    //MARK: - Scroll view control functions
    
    func setScrollView(){
        
        scrollView.delegate = self
        scrollView.frame.size = self.view.frame.size
        viewHierarchy.append(scrollView)
        scrollView.scrollEnabled = false
        scrollView.minimumZoomScale = 0.001
        scrollView.maximumZoomScale = 1000000
        self.view.bringSubviewToFront(scrollView)
        currentViewIndex = 0


    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = presentationMapView.frame
        
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
        
        presentationMapView.frame = contentsFrame
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return presentationMapView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    
        if (scrollView.zoomScale < 1){
            currentViewIndex = 0
        }
        if (scrollView.zoomScale >= 1){
            currentViewIndex = 1
        }
        if (scrollView.zoomScale >= 100){
            currentViewIndex = 2
        }
        if (scrollView.zoomScale >= 10000){
            currentViewIndex = 3
        }
        if (scrollView.zoomScale >= 1000000){
            currentViewIndex = 4
        }
    }
    
    func createGestureRecognizers(){
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "zoomIn")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        scrollView.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "zoomOut")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        scrollView.addGestureRecognizer(swipeRight)
        
    }
    
    //MARK: - Zoom control functions
    
    
    func zoomIn(){
        
        if (currentViewIndex < viewHierarchy.count - 1){
            let rectToZoom:CGRect = presentationMapView.convertRect(viewHierarchy[currentViewIndex + 1].frame, fromCoordinateSpace:viewHierarchy[currentViewIndex + 1].superview!)
            currentViewIndex++
            scrollView.zoomToRect(rectToZoom, animated: true)
        }
        
    }
    
    func zoomOut(){
        
        if (currentViewIndex > 1){
            let rectToZoom:CGRect = presentationMapView.convertRect(viewHierarchy[currentViewIndex-1].frame, fromCoordinateSpace: viewHierarchy[currentViewIndex-1].superview!)
            currentViewIndex--
            scrollView.zoomToRect(rectToZoom, animated: true)
        }
    }
    
    //MARK: - Black view functions
    
    func drawBlackView(){
    
        self.view.backgroundColor = UIColor.blackColor()
        
        let titleFont = UIFont(name: "Euphemia UCAS", size: 25)
        
        var firstViewLabel = UILabel(frame: CGRectMake(self.view.frame.width*0.05, self.view.frame.height*0.1, self.view.frame.width, self.view.frame.height*0.1))
        firstViewLabel.font = titleFont
        firstViewLabel.textColor = UIColor.whiteColor()
        firstViewLabel.text = "Can't see?"
        firstViewLabel.alpha = 0.0
        self.view.addSubview(firstViewLabel)
        
        var secondViewLabel = UILabel(frame: CGRectMake(self.view.frame.width*0.15, self.view.frame.height*0.2, self.view.frame.width, self.view.frame.height*0.1))
        secondViewLabel.font = titleFont
        secondViewLabel.textColor = UIColor.whiteColor()
        secondViewLabel.text = "Maybe you should..."
        secondViewLabel.alpha = 0.0
        self.view.addSubview(secondViewLabel)
        
        var thirdViewLabel = UILabel(frame: CGRectMake(self.view.frame.width*0.25, self.view.frame.height*0.3, self.view.frame.width, self.view.frame.height*0.1))
        thirdViewLabel.font = titleFont
        thirdViewLabel.textColor = UIColor.whiteColor()
        thirdViewLabel.text = "Zoom in a bit..."
        thirdViewLabel.alpha = 0.0
        self.view.addSubview(thirdViewLabel)
        
        UIView.animateWithDuration(1.5, animations: {() -> Void in
            firstViewLabel.alpha = 1.0
            
            return
            },completion:{finished in
                UIView.animateWithDuration(1.5, animations: {() -> Void in
                    secondViewLabel.alpha = 1.0
                    
                    return
                    },completion:{finished in
                        UIView.animateWithDuration(1.5, animations: {() -> Void in
                            thirdViewLabel.alpha = 1.0
                            
                            return
                        })
                })
                
        })

    
    }
    
    //MARK: - Presentation and Map view functions
    
    func drawPresentationView(){
        
        let containerSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height)
        presentationMapView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size:containerSize))
        presentationMapView.backgroundColor = UIColor.whiteColor()
        presentationMapView.layer.cornerRadius = 20
        scrollView.addSubview(presentationMapView)
        presentationMapView.center = scrollView.convertPoint(scrollView.center, fromCoordinateSpace: scrollView.superview!)
        viewHierarchy.append(presentationMapView)
        
        blackView = UIView(frame: presentationMapView.frame)
        blackView.backgroundColor = UIColor.blackColor()
        presentationMapView.addSubview(blackView)
        
        var presentationTextView = UITextView(frame: CGRectMake(presentationMapView.frame.width * 0.1, presentationMapView.frame.height * 0.05, presentationMapView.frame.width * 0.8, presentationMapView.frame.height*0.45))
        presentationTextView.text = "Hello! Welcome to my app. In this app you will go to depths never explored in the Iphone while getting to know about me! The app is pretty simple: just keep zooming in the center of the screen the explore the tiniest bits of the Iphone, or swipe left and right to navigate the screens."
        presentationTextView.userInteractionEnabled = false
        presentationTextView.font = font
        presentationMapView.addSubview(presentationTextView)
        
        var mapLabel = UILabel(frame: CGRectMake(presentationMapView.frame.width * 0.15, presentationMapView.frame.height * 0.52, presentationMapView.frame.width*0.85, presentationMapView.frame.height*0.1))
        mapLabel.text = "Where I am right now!"
        mapLabel.font = font
        presentationMapView.addSubview(mapLabel)
        
        var mapView = MKMapView(frame: CGRectMake(self.presentationMapView.frame.width*0.05, presentationMapView.frame.height*0.62, presentationMapView.frame.width*0.9, presentationMapView.frame.height*0.35))
        mapView.delegate = self
        mapView.userInteractionEnabled = false
        presentationMapView.addSubview(mapView)
        
         var myLocationRef = Firebase(url:"https://sizzling-inferno-6992.firebaseio.com/MyLocation")
        
        myLocationRef.observeEventType(.Value, withBlock: { snapshot in
            let latitude = snapshot.value["latitude"]
            let longitude = snapshot.value["longitude"]
            var centerLocation = CLLocationCoordinate2DMake(latitude as! CLLocationDegrees,longitude as! CLLocationDegrees
            )
            var mapSpan = MKCoordinateSpanMake(0.01, 0.01)
            var mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
            mapView.setRegion(mapRegion, animated: true)
            var point = MKPointAnnotation()
            point.coordinate = centerLocation
            mapView.addAnnotation(point)
        })

        var myRootRef = Firebase(url:"https://sizzling-inferno-6992.firebaseio.com")
        myRootRef.observeEventType(.ChildChanged, withBlock: { snapshot in
            let latitude: AnyObject? = snapshot.value.objectForKey("latitude")
            let longitude: AnyObject? = snapshot.value.objectForKey("longitude")
            var centerLocation = CLLocationCoordinate2DMake(latitude as! CLLocationDegrees,longitude as! CLLocationDegrees
            )
            var mapSpan = MKCoordinateSpanMake(0.01, 0.01)
            var mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
            mapView.setRegion(mapRegion, animated: true)
            var point = MKPointAnnotation()
            point.coordinate = centerLocation
            mapView.addAnnotation(point)
        })
        
       
        presentationMapView.bringSubviewToFront(blackView)

    
    }
    
    //MARK: - Skills and Education view functions

    func zoomSkillView(sender:UITapGestureRecognizer){
        
        if (isSkillViewZoomed){
            if (sender.view == skillZoomedView){
                
                UIView.animateWithDuration(0.5, animations: {() -> Void in
                    sender.view?.frame = self.originalFrame
                    
                    return
                })
                
                UIView.animateWithDuration(0.5, animations: {() -> Void in
                    sender.view?.alpha = 0.5
                    
                    return
                    }, completion:{finished in
                        if (self.skillZoomedView == self.skillsArray[0])
                        {
                        self.skillsArray[0].image = UIImage(named: "c")
                        }
                        if (self.skillZoomedView == self.skillsArray[1])
                        {
                            self.skillsArray[1].image = UIImage(named: "csharp")
                        }
                        if (self.skillZoomedView == self.skillsArray[2])
                        {
                            self.skillsArray[2].image = UIImage(named: "objc")
                        }
                        if (self.skillZoomedView == self.skillsArray[3])
                        {
                            self.skillsArray[3].image = UIImage(named: "swift")
                        }
                        if (self.skillZoomedView == self.skillsArray[4])
                        {
                            self.skillsArray[4].image = UIImage(named: "html")
                        }
                        if (self.skillZoomedView == self.skillsArray[5])
                        {
                            self.skillsArray[5].image = UIImage(named: "java")
                        }
                        if (self.skillZoomedView == self.skillsArray[6])
                        {
                            self.skillsArray[6].image = UIImage(named: "php")
                        }
                        if (self.skillZoomedView == self.skillsArray[7])
                        {
                            self.skillsArray[7].image = UIImage(named: "terminal")
                        }
                        if (self.skillZoomedView == self.skillsArray[8])
                        {
                            self.skillsArray[8].image = UIImage(named: "github")
                        }
                })
                isSkillViewZoomed = false
            
            }
        }
        else{
        originalFrame = sender.view?.frame
        educationSkillView.bringSubviewToFront(sender.view!)
           
        
        UIView.animateWithDuration(1, animations: {() -> Void in
            sender.view?.frame = CGRectMake(0, self.educationSkillView.frame.height*0.6, self.educationSkillView.frame.width, self.educationSkillView.frame.height*0.4)
            
            
            return
            }, completion:{finished in
                if (self.skillZoomedView == self.skillsArray[0])
                {
                    self.skillsArray[0].image = UIImage(named: "ctext")
                }
                if (self.skillZoomedView == self.skillsArray[1])
                {
                    self.skillsArray[1].image = UIImage(named: "csharptext")
                }
                if (self.skillZoomedView == self.skillsArray[2])
                {
                    self.skillsArray[2].image = UIImage(named: "objctext")
                }
                if (self.skillZoomedView == self.skillsArray[3])
                {
                    self.skillsArray[3].image = UIImage(named: "swifttext")
                }
                if (self.skillZoomedView == self.skillsArray[4])
                {
                    self.skillsArray[4].image = UIImage(named: "htmltext")
                }
                if (self.skillZoomedView == self.skillsArray[5])
                {
                    self.skillsArray[5].image = UIImage(named: "javatext")
                }
                if (self.skillZoomedView == self.skillsArray[6])
                {
                    self.skillsArray[6].image = UIImage(named: "phptext")
                }
                if (self.skillZoomedView == self.skillsArray[7])
                {
                    self.skillsArray[7].image = UIImage(named: "terminaltext")
                }
                if (self.skillZoomedView == self.skillsArray[8])
                {
                    self.skillsArray[8].image = UIImage(named: "githubtext")
                }
            })
            isSkillViewZoomed = true
            skillZoomedView = sender.view
            
        }
        
    }
    
    func drawEducationSkillView(){
        
        educationSkillView = UIView(frame: CGRect(x: 0, y: 0, width: presentationMapView.frame.size.width * prop, height: presentationMapView.frame.size.height * prop))
        presentationMapView.addSubview(educationSkillView)
        educationSkillView.center = presentationMapView.convertPoint(presentationMapView.center, fromCoordinateSpace: presentationMapView.superview!)
        viewHierarchy.append(educationSkillView)
        
        
        let educationImageView:UIImageView = UIImageView(frame: CGRectMake(educationSkillView.frame.width/10, educationSkillView.frame.height/20, educationSkillView.frame.width*0.8, educationSkillView.frame.height/12))
        educationImageView.image = UIImage(named: "educationtitle")
        educationSkillView.addSubview(educationImageView)
        
        let educationText:UIImageView = UIImageView(frame: CGRectMake(0, educationSkillView.frame.height/8, educationSkillView.frame.width, educationSkillView.frame.height*0.4))
        educationText.image = UIImage(named: "educationtext")
        educationSkillView.addSubview(educationText)
        
        let programmingSkills:UIImageView = UIImageView(frame: CGRectMake(educationSkillView.frame.width/10, educationSkillView.frame.height*0.52, educationSkillView.frame.width*0.8, educationSkillView.frame.height/15))
        programmingSkills.image = UIImage(named: "programmingskills")
        educationSkillView.addSubview(programmingSkills)
        
        let propSub:CGFloat = 5
        let diameter:CGFloat = educationSkillView.frame.width/propSub
        var baseY:CGFloat = educationSkillView.frame.height/2 + educationSkillView.frame.height/20 + diameter/4
        var baseX:CGFloat = diameter/2
        
        for var indexOut = 0; indexOut < 3; indexOut+=1{
            
            for var indexIn = 0; indexIn < 3; indexIn+=1{
        
                let skillsImageView: UIImageView = UIImageView(frame: CGRectMake(baseX, baseY, diameter, diameter))
                skillsImageView.userInteractionEnabled = true
                
                educationSkillView.addSubview(skillsImageView)
                skillsArray.append(skillsImageView)
                
                let tapGesture = UITapGestureRecognizer(target: self, action: "zoomSkillView:")
                skillsImageView.addGestureRecognizer(tapGesture)
                baseX = baseX + diameter/2 + diameter
                
            }
            baseY = baseY + diameter/4 + diameter
            baseX = diameter/2
        }
        skillsArray[0].image = UIImage(named: "c")
        skillsArray[1].image = UIImage(named: "csharp")
        skillsArray[2].image = UIImage(named: "objc")
        skillsArray[3].image = UIImage(named: "swift")
        skillsArray[4].image = UIImage(named: "html")
        skillsArray[5].image = UIImage(named: "java")
        skillsArray[6].image = UIImage(named: "php")
        skillsArray[7].image = UIImage(named: "terminal")
        skillsArray[8].image = UIImage(named: "github")
      

    }
    
    //MARK: - Hobbies and Projects functions
    
    func  drawHobbiesEducationView(){
    
        hobbiesProjectsView = UIView(frame: CGRect(x: 0, y: 0, width: educationSkillView.frame.size.width * prop, height: educationSkillView.frame.size.height * prop))
        educationSkillView.backgroundColor = UIColor.whiteColor()
        educationSkillView.addSubview(hobbiesProjectsView)
        hobbiesProjectsView.center = educationSkillView.convertPoint(educationSkillView.center, fromCoordinateSpace: educationSkillView.superview!)
        viewHierarchy.append(hobbiesProjectsView)
        
        var hobbiesLabel = UIImageView(frame: CGRectMake(0, hobbiesProjectsView.frame.height/25, hobbiesProjectsView.frame.width, hobbiesProjectsView.frame.height/20))
        hobbiesLabel.image = UIImage(named: "hobbiestitle")
        hobbiesProjectsView.addSubview(hobbiesLabel)

        
        var projectsLabel = UIImageView(frame: CGRectMake(0, hobbiesProjectsView.frame.height*0.53, hobbiesProjectsView.frame.width, hobbiesProjectsView.frame.height/20))
        projectsLabel.image = UIImage(named: "projectstitle")
        hobbiesProjectsView.addSubview(projectsLabel)
        
        var firstProject = UIImageView(frame: CGRectMake(0, hobbiesProjectsView.frame.height * 0.6, hobbiesProjectsView.frame.width * 0.5 , hobbiesProjectsView.frame.height * 0.4))
        firstProject.image = UIImage(named: "orbilis")
        firstProject.userInteractionEnabled = true
        let orbilisTapGesture = UITapGestureRecognizer(target: self, action: "tapProject:")
        firstProject.addGestureRecognizer(orbilisTapGesture)
        hobbiesProjectsView.addSubview(firstProject)
        projectArray.append(firstProject)
        
        var secondProject = UIImageView(frame: CGRectMake(hobbiesProjectsView.frame.width * 0.5, hobbiesProjectsView.frame.height * 0.6, hobbiesProjectsView.frame.width * 0.5 , hobbiesProjectsView.frame.height * 0.4))
        secondProject.image = UIImage(named: "bepidgo")
        secondProject.userInteractionEnabled = true
        let bepidGoTapGesture = UITapGestureRecognizer(target: self, action: "tapProject:")
        secondProject.addGestureRecognizer(bepidGoTapGesture)
        hobbiesProjectsView.addSubview(secondProject)
        projectArray.append(secondProject)

        
        
        var baseX = hobbiesProjectsView.frame.width/10
        var currentX = baseX
        var squareSide = hobbiesProjectsView.frame.width/5
        for var index = 0; index < 3; index+=1{
            
        var hobbieView = UIImageView(frame: CGRectMake(currentX, hobbiesProjectsView.frame.height/10, squareSide, squareSide))
        hobbieView.userInteractionEnabled = true
        hobbiesArray.append(hobbieView)
        hobbiesProjectsView.addSubview(hobbieView)
        let tapGesture = UITapGestureRecognizer(target: self, action: "zoomHobbie:")
        hobbieView.addGestureRecognizer(tapGesture)
        currentX = currentX + baseX + squareSide
        
        }
        baseX = hobbiesProjectsView.frame.width/5
        currentX = baseX
        var baseY =  hobbiesProjectsView.frame.height/7 + squareSide
        for var index = 0; index < 2; index+=1{
            for var subIndex = 0; subIndex < 2; subIndex+=1{
                
            var hobbieView = UIImageView(frame: CGRectMake(currentX, baseY, squareSide, squareSide))
            hobbieView.userInteractionEnabled = true
            hobbiesArray.append(hobbieView)
            hobbiesProjectsView.addSubview(hobbieView)
            let tapGesture = UITapGestureRecognizer(target: self, action: "zoomHobbie:")
            hobbieView.addGestureRecognizer(tapGesture)
            
            currentX = currentX + baseX + squareSide
            
            }
            currentX = baseX
            baseY = baseY + squareSide + hobbiesProjectsView.frame.height/30
        }
        
        hobbiesArray[0].image = UIImage(named: "games")
        hobbiesArray[1].image = UIImage(named: "cat")
        hobbiesArray[2].image = UIImage(named: "chess")
        hobbiesArray[3].image = UIImage(named: "football")
        hobbiesArray[4].image = UIImage(named: "book")
        hobbiesArray[5].image = UIImage(named: "tech")
        hobbiesArray[6].image = UIImage(named: "cinema")

        
        
    
    }

    func tapProject(sender:UITapGestureRecognizer){
        if (isProjectViewZoomed){
            UIView.animateWithDuration(0.5, animations: {() -> Void in
                sender.view?.frame = self.projectOriginalFrame
                return
                },completion:{finished in
                    if (self.projectZoomedView == self.projectArray[0]){
                        self.projectArray[0].image = UIImage(named: "orbilis")
                    }
                    if (self.projectZoomedView == self.projectArray[1]){
                        self.projectArray[1].image = UIImage(named: "bepidgo")
                    }
            })
            isProjectViewZoomed = false
        }else{
            projectZoomedView = sender.view
            projectOriginalFrame = sender.view?.frame
            UIView.animateWithDuration(0.5, animations: {() -> Void in
                sender.view?.frame = CGRectMake(0, 0, self.hobbiesProjectsView.frame.width, self.hobbiesProjectsView.frame.height)
                sender.view?.superview?.bringSubviewToFront(sender.view!)
                return
                },completion:{finished in
                    if (self.projectZoomedView == self.projectArray[0]){
                        self.projectArray[0].image = UIImage(named: "orbilisdetails")
                    }
                    if (self.projectZoomedView == self.projectArray[1]){
                        self.projectArray[1].image = UIImage(named: "bepidgodetails")
                    }
            })
            isProjectViewZoomed = true
        }
    }

       func zoomHobbie(sender:UITapGestureRecognizer){
        if(isHobbieViewZoomed){
            UIView.animateWithDuration(0.5, animations: {() -> Void in
                sender.view?.alpha = 0.5
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
        hobbiesProjectsView.bringSubviewToFront(sender.view!)
        UIView.animateWithDuration(1, animations: {() -> Void in
            
            sender.view?.frame = CGRectMake(0, self.hobbiesProjectsView.frame.height/12
                , self.hobbiesProjectsView.frame.width, self.hobbiesProjectsView.frame.height*0.45)
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
    //MARK: - Profile Functions
    
    func drawProfileView(){
        
        profileView = UIImageView(frame: CGRect(x: 0, y: 0, width: hobbiesProjectsView.frame.size.width * prop, height: hobbiesProjectsView.frame.size.height * prop))
        hobbiesProjectsView.addSubview(profileView)
        profileView.center = hobbiesProjectsView.convertPoint(hobbiesProjectsView.center, fromCoordinateSpace: hobbiesProjectsView.superview!)
        profileView.image = UIImage(named: "profile")
        viewHierarchy.append(profileView)
        
    }
}
    
