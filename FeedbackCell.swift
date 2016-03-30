//
//  NotficationBodyViewCell.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 10.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import Foundation
import Cartography
import SwiftyJSON

class FeedbackCell: UITableViewCell {
    // MARK: - Properties -
    var avatarView: SKAvatarContainerView!
    private(set) var descriptionView: DescriptionView!
    var viewHeight: NSLayoutConstraint?
    
    func descriptionViewClass() -> DescriptionView.Type {
        return DescriptionView.self
    }
    
    // MARK: - Initialization -
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setUpViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func reset() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.descriptionView.reset()
        self.avatarView.reset()
    }
    
    private func commonInit() {
        self.setUpViews()
        
        self.reset()
    }
    
    func reload(data: SKBaseFeedback) {
        self.reset()
        self.descriptionView.reload(data)
        self.avatarView.reload(data)
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    /*
        Настройка контейнеров для аватара, описания и
        футера
        Настройка constraints
    */
    private func setUpViews() {
        self.clipsToBounds = true
        
        self.avatarView = SKAvatarContainerView()
        self.descriptionView = self.descriptionViewClass().init()
        
        self.contentView.addSubview(self.avatarView)
        self.contentView.addSubview(self.descriptionView)
        
        constrain(avatarView, descriptionView) { avatarView, descriptionView in
            guard let superview = avatarView.superview else { return }
            
            avatarView.left == superview.left + FeedbackConstants.Padding.avatarView
            avatarView.top == superview.top + FeedbackConstants.Padding.avatarView
            avatarView.bottom <= superview.bottom - FeedbackConstants.Padding.avatarView ~ 900
            
            descriptionView.top == superview.top + FeedbackConstants.Padding.descriptionView
            descriptionView.left == avatarView.right + FeedbackConstants.Padding.descriptionView
            descriptionView.right == superview.right - FeedbackConstants.Padding.descriptionView
            descriptionView.bottom <= superview.bottom - FeedbackConstants.Padding.descriptionView ~ 900            
        }
        
        self.descriptionView.setContentCompressionResistancePriority(900, forAxis: UILayoutConstraintAxis.Vertical)
    }
}
