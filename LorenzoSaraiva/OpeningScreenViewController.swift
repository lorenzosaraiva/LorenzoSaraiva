//
//  OpeningScreenViewController.swift
//  LorenzoSaraiva
//
//  Created by Lorenzo Saraiva on 4/15/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

import UIKit

let transition = Animator()

class OpeningScreenViewController: UIViewController {
    
    var ballArray:[UIView] = []
    var imageView:UIImageView!
    let transtion = Animator()
    
    //MARK: Default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawScreen()
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Draw functions
    
    func drawScreen(){
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        var indexHor : CGFloat
        var indexVer : CGFloat
        for indexHor = 0; indexHor < screenWidth; indexHor+=12 {
            
            for indexVer = 0; indexVer < screenHeight; indexVer+=12 {
                
                var newView : UIView = UIView(frame: CGRectMake(indexHor, indexVer, 10, 10))
                newView.backgroundColor =  UIColor(red:(indexVer/2)/255, green:(indexHor/2)/255,blue:(indexHor + indexVer/2)/255,alpha:1.0)
                if (indexHor > view.frame.size.width/2 - 70 && indexHor < view.frame.size.width/2 + 70 && indexVer > view.frame.size.height/2 - 100 && indexVer < view.frame.size.height/2 + 100){
                    continue;
                }
                let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
                tapGesture.addTarget(self, action: "tapOnBall:")
                newView.addGestureRecognizer(tapGesture)
                newView.layer.cornerRadius = 5.0
                view.addSubview(newView)
                ballArray.append(newView)
                
            }
        }
        addImageView()
    }
    
    func addImageView(){
        
        imageView = UIImageView(frame: CGRectMake(view.frame.size.width/2 - 60, view.frame.size.height/2 - 92, 135, 190))
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: "tapImage")
        imageView.addGestureRecognizer(tapGesture)
        imageView.image = UIImage(named: "tower.png")
        imageView.userInteractionEnabled = true
        view.addSubview(imageView)

    
    }
    
    //MARK: Gestures handlers
    
    func tapOnBall(recognizer:UITapGestureRecognizer){
        var spinView: UIView = recognizer.view!
        UIView.animateWithDuration(0.5, delay: 0.0, options: nil, animations: {
            spinView.center.x += spinView.bounds.width
            }, completion: nil)
    }
    
    func tapImage(){
        // Image view fade-out
        
        UIView.animateWithDuration(4, animations: {() -> Void in
            self.imageView.alpha = 0
            return
            }, completion: {finished in self.performSegueWithIdentifier("mainScreen", sender: self)
        })
        for var index = 0; index < ballArray.count; index++ {
            var tempView = ballArray[index]
            var r = CGFloat(arc4random()%255)
            var g = CGFloat(arc4random()%255)
            var b = CGFloat(arc4random()%255)
            
        // Views changing color
            
            UIView.animateWithDuration(2, animations: {() -> Void in
                tempView.backgroundColor = UIColor(red:r/255, green:g/255,blue:b/255,alpha:1)
                return
            })
            
        // Views changing position
            
            UIView.animateWithDuration(4, animations: {() -> Void in
                if (tempView.frame.origin.y > self.view.frame.height/2){
                    tempView.frame.origin.y = -tempView.frame.height
                    if (tempView.frame.origin.x > self.view.frame.width/2){
                        tempView.frame.origin.x = -tempView.frame.width
                    
                }
                else{
                        tempView.frame.origin.x = self.view.frame.width
                }
                }
                else{
                    tempView.frame.origin.y = self.view.frame.height
                    if (tempView.frame.origin.x > self.view.frame.width/2){
                        tempView.frame.origin.x = -tempView.frame.width
                        
                    }
                    else{
                        tempView.frame.origin.x = self.view.frame.width
                    }

                }
                return
            })
        }
    
        //Going to next VC
//        var mainScreenVC = MainScreenViewController()
//        mainScreenVC.transitioningDelegate = self
//        presentViewController(mainScreenVC, animated: true, completion: nil)
        
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
//extension OpeningScreenViewController: UIViewControllerTransitioningDelegate{
//   
//    func animationControllerForPresentedController(
//        presented: UIViewController,
//        presentingController presenting: UIViewController,
//        sourceController source: UIViewController) ->
//        UIViewControllerAnimatedTransitioning? {
//            return transition
//    }
//    
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return nil
//    }
//}
