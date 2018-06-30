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

private enum Metrics {
    static let spacing: CGFloat = 13.0
    static let top: CGFloat = 13.0
    static let bottom: CGFloat = 13.0
}

class FactTableViewCell: UITableViewCell, Reusable {
    
    //MARK: - Vars
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var factImageView: UIImageView!
    private var allConstraints: [NSLayoutConstraint] = []
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubViewsAndlayout()
        makeSubViewsConstraintReady()
        formatLabels()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViewsAndlayout() {
        titleLabel = initLabel()
        descriptionLabel = initLabel()
        factImageView = initImageView()
        
        addSubView(subViews: [titleLabel, descriptionLabel, factImageView])
    }
    
    /**
     * To populate the cell with Fact
     * Parameters: Fact
     */
    func populate(with fact: Fact) {
        factImageView.image = nil
        titleLabel.attributedText = NSAttributedString(string: fact.title ?? "", attributes:
            [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        descriptionLabel.text = fact.description
        
        guard let iconURL = URL(string: fact.imageHref ?? ""),
            factImageView.image == nil else { return }
        
        factImageView.kf.indicatorType = .activity
        factImageView.kf.setImage(with: iconURL,
                             placeholder: UIImage(named:"placeholderImage"),
                             options: [.transition(ImageTransition.fade(1))],
                             completionHandler: { [weak self] image, error, cacheType, imageURL in
                                self?.factImageView.kf.indicatorType = .none
        })
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
    
    func makeSubViewsConstraintReady() {
        [titleLabel, descriptionLabel, factImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func initLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    func initImageView() -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    func addSubView(subViews: [UIView]) {
        subViews.forEach { contentView.addSubview($0) }
    }
    
    func setupConstraints() {
        if !allConstraints.isEmpty {
            NSLayoutConstraint.deactivate(allConstraints)
            allConstraints.removeAll()
        }
        
        let views: [String: UIView] = ["factImageView": factImageView, "titleLabel": titleLabel, "descriptionLabel": descriptionLabel]
        
        let metrics = [
            "verticalSpacing": Metrics.spacing,
            "topMargin": Metrics.top,
            "bottomMargin": Metrics.bottom,
            "leftMargin": Metrics.spacing,
            "rightMargin": Metrics.spacing]
        
        // factImageView is as wide as its superView and it is stuck to both sides
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-leftMargin-[factImageView]-rightMargin-|", options: [], metrics: metrics, views: views)
        
        // titleLabel is with dynamic height and stuck to both sides
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-leftMargin-[titleLabel]-rightMargin-|", options: [], metrics: metrics, views: views)
        
        // descriptionLabel is with dynamic height and stuck to both sides
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-leftMargin-[descriptionLabel]-rightMargin-|", options: [], metrics: metrics, views: views)
        
        // vertical constraints
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-topMargin-[factImageView]-verticalSpacing-[titleLabel(30)]-verticalSpacing-[descriptionLabel]-bottomMargin-|", options: [], metrics: metrics, views: views)
        
        NSLayoutConstraint.activate(allConstraints)
    }
}
