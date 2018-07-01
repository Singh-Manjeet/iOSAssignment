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

private struct Design {
    static let placeHolderImage = UIImage(named:"placeholderImage")
}

private enum Metrics {
    static let spacing: CGFloat = 13.0
    static let top: CGFloat = 13.0
    static let bottom: CGFloat = 13.0
    static let minimumHeight: CGFloat = 22.0
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
        super.init(coder: aDecoder)
    }
    
    /**
     * To populate the cell with Fact
     * Parameters: Fact
     */
    func populate(with fact: Fact) {
        updateUI(with: fact)
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
    
    func updateUI(with fact: Fact) {
        guard let title = fact.title,
              let description = fact.description else { return }
        
        let formattedString = NSMutableAttributedString()
        formattedString.bold(title)
        titleLabel.attributedText = formattedString
        
        descriptionLabel.text = description
        factImageView.image = nil
    
        guard let iconURL = URL(string: fact.imageHref ?? "") else { return }
        
        factImageView.kf.indicatorType = .activity
        factImageView.kf.setImage(with: iconURL,
                                  placeholder: Design.placeHolderImage,
                                  options: [.transition(ImageTransition.fade(1))],
                                  completionHandler: { [weak self] image, error, cacheType, imageURL in
                                    self?.factImageView.kf.indicatorType = .none
        })
    }
    
    func addSubViewsAndlayout() {
        titleLabel = initLabel()
        descriptionLabel = initLabel()
        factImageView = initImageView()
        
        addSubView(subViews: [titleLabel, descriptionLabel, factImageView])
    }
    
    func makeSubViewsConstraintReady() {
        [titleLabel, descriptionLabel, factImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
        [descriptionLabel, titleLabel].forEach {
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
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
    
    //MARK: - Constraints Setup Using Visual Format Language
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
            "rightMargin": Metrics.spacing,
            "height": Metrics.minimumHeight]
        
        // factImageView is as wide as its superView and it is stuck to both sides
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-leftMargin-[factImageView]-rightMargin-|", options: [], metrics: metrics, views: views)
        
        // titleLabel is with dynamic height and stuck to both sides
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-leftMargin-[titleLabel]-rightMargin-|", options: [], metrics: metrics, views: views)
        
        // descriptionLabel is with dynamic height and stuck to both sides
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-leftMargin-[descriptionLabel]-rightMargin-|", options: [], metrics: metrics, views: views)
        
        // vertical constraints
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-topMargin-[factImageView]-verticalSpacing-[titleLabel]-verticalSpacing-[descriptionLabel]-bottomMargin-|", options: [], metrics: metrics, views: views)
        
        NSLayoutConstraint.activate(allConstraints)
    }
}
