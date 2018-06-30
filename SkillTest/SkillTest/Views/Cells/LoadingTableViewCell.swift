//
//  LoadingTableViewCell.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit

class LoadingTableViewCell: UITableViewCell, Reusable {
    //MARK: Subviews
    private var activityIndicator: UIActivityIndicatorView {
        return UIActivityIndicatorView(frame: .zero)
    }
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViewsAndlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViewsAndlayout() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
        }
    }
}
