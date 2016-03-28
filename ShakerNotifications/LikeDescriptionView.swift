//
//  InterestDescriptionView.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography

class LikeDescriptionView: DescriptionView {
    private(set) var baseData: SKLikeFeedback!
    private(set) var rightSideConstraint: NSLayoutConstraint?
    
    let group = ConstraintGroup()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.localInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.localInit()
    }
    
    override func reset() {
        super.reset()
    }
    
    private func localInit() {
        /*
        constrain(self.descriptionLabel, self.descriptionButton) { descriptionLabel, descriptionButton in
            guard let superview = descriptionLabel.superview else { return }
            
            descriptionLabel.top == superview.top
            descriptionLabel.left == superview.left
            
            viewHeight = (superview.height == 100 ~ 100)
        }
        
        constrain(self.descriptionLabel, replace: group) { descriptionLabel in
            guard let superview = descriptionLabel.superview else { return }
//            descriptionLabel.right == superview.right - 10
        }
        */
    }
    
    override func reload(data: SKBaseFeedback) {
        super.reload(data)
        
        switch data.feedbackModelType {
        case .LikeInterest:
            baseData = data as? SKLikeInterestFeedback
        case .LikeQuote:
            baseData = data as? SKLikeQuoteFeedback
        case .LikeShake:
            baseData = data as? SKLikeShakeFeedback
        default:
            baseData = data as? SKLikeFeedback
        }
        
        var height: CGFloat = 0
        
        if baseData.photos == nil {
            setHiddenButtonConstraints()
            height = descriptionLabel.frame.height
        } else {
            setVisibleButtonConstraints()
            
            if (baseData.count != nil) {
                self.descriptionButton.backgroundColor = UIColor.whiteColor()
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] in
                    guard let photos = self?.baseData.photos?[0] else { return }
                    
                    let imageUrl = NSURL(string: photos)
                    let imageData = NSData(contentsOfURL: imageUrl!)
                    let image: UIImage = UIImage(data: imageData!)!
                    
                    dispatch_async(dispatch_get_main_queue()) { [weak self] in
                        self?.descriptionButton.setImage(image, forState: .Normal)
                        self?.descriptionButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
                    }
                }
            } else {
                self.descriptionButton.setImage(UIImage(named: ""), forState: .Normal)
                self.descriptionButton.imageView?.contentMode = UIViewContentMode.Center
            }
            
            height = descriptionLabel.frame.height > descriptionButton.frame.height ? descriptionLabel.frame.height : descriptionButton.frame.height
        }
        
//        viewHeight?.constant = height
    }
    
    // TODO : Сделать метод для перехода в публикацию шейка.
    override func buttonDidTouch(sender: UIButton!) {
//        let interestSourceUrl = NSURL(string: "shaker://interestSource/\(baseData.id)")!
//        UIApplication.sharedApplication().openURL(interestSourceUrl)
    }
}