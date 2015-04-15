//
//  OpeningScreenViewController.swift
//  LorenzoSaraiva
//
//  Created by Lorenzo Saraiva on 4/15/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

import UIKit

class OpeningScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        drawScreen()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func drawScreen(){
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        var indexHor : CGFloat
        var indexVer : CGFloat
        for indexHor = 0; indexHor < screenWidth; indexHor+=12 {
            
            for indexVer = 0; indexVer < screenHeight; indexVer+=12 {
                
                var newView : UIView = UIView(frame: CGRectMake(indexHor, indexVer, 10, 10))
                newView.backgroundColor =  UIColor(red:(indexVer/2)/255, green:(indexHor/2)/255,blue:(indexHor + indexVer/2)/255,alpha:1.0)
                
                let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
                tapGesture.addTarget(self, action: "tapAction:")
                newView.addGestureRecognizer(tapGesture)
                newView.layer.cornerRadius = 5.0
                view.addSubview(newView)
                
            }
        }
    }
    
    func tapAction(recognizer:UITapGestureRecognizer){
        var spinView: UIView = recognizer.view!
        UIView.animateWithDuration(0.5, delay: 0.0, options: nil, animations: {
            spinView.center.x += spinView.bounds.width
            }, completion: nil)
}
}
