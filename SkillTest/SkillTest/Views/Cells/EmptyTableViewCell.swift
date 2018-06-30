//
//  EmptyTableViewCell.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit

class EmptyTableViewCell: UITableViewCell, Reusable {
    //MARK: Subviews
    var titleLabel: UILabel {
        return UILabel(frame: .zero)
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
        titleLabel.text = "No data available, Please try again"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).offset(13.0)
        }
    }
}
