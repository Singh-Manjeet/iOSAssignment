//
//  FactTableViewCell.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class FactTableViewCell: UITableViewCell, Reusable {
    //MARK: Subviews
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var iconView: UIImageView!
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViewsAndlayout()
        formatLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                iconView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                aspectConstraint?.priority = UILayoutPriority(999)
                iconView.addConstraint(aspectConstraint!)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    
    func addSubViewsAndlayout() {
        titleLabel = UILabel(frame: .zero)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.clipsToBounds = true
        
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.clipsToBounds = true
        
        iconView = UIImageView(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(13.0)
            make.leftMargin.rightMargin.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(13.0)
            make.leftMargin.rightMargin.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottomMargin)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
        }
    }
    
    /**
     * To populate the cell with Fact
     * Parameters: Fact
     */
    func populate(with fact: Fact) {
        titleLabel.attributedText = NSAttributedString(string: fact.title ?? "", attributes:
            [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        descriptionLabel.text = fact.description
        
        if let factImageURL = fact.imageHref,
            let imageURL = URL(string: factImageURL) {
            iconView.kf.indicatorType = .activity
            
            let resource = ImageResource(downloadURL: imageURL, cacheKey: factImageURL)
            
            
            self.iconView.kf.setImage(with: resource,
                                      completionHandler: { [weak self]  (image, error, cacheType, imageUrl) in
                                        
                                        guard let strongSelf = self, let image = image else { return }
                                        let aspect = image.size.width / image.size.height
                                        strongSelf.aspectConstraint = NSLayoutConstraint(item: strongSelf.iconView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: strongSelf.iconView, attribute: NSLayoutAttribute.height, multiplier: aspect, constant: 0.0)
                                        
                                        strongSelf.layoutIfNeeded()
                                        strongSelf.updateConstraintsIfNeeded()
            })
        }
    }
}

// MARK: - Private Helpers
private extension FactTableViewCell {
    func formatLabels() {
        [titleLabel, descriptionLabel].forEach {
            $0?.textColor = .orange
            $0?.font = UIFont(name: "Helvetica", size: 16.0)
        }
    }
}
