//
//  ProfileTabViewController.swift
//  
//
//  Created by Lorenzo Saraiva on 4/14/15.
//
//

import UIKit

class ProfileTabViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    
    var imageIndex = 1
    let imageArray:[UIImage] = [UIImage(named: "horse.png")!, UIImage(named: "pawn.png")!, UIImage(named: "tower.png")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.image = imageArray[0]
        
        let swipe = UISwipeGestureRecognizer(target: self, action: "imageSwipe")
        swipe.direction = UISwipeGestureRecognizerDirection.Left
        mainImage.addGestureRecognizer(swipe)
        mainImage.userInteractionEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imageSwipe() {
        mainImage.image = imageArray[imageIndex]
        imageIndex++
        if (imageIndex == imageArray.count){
            imageIndex = 0
        }
    }
}
