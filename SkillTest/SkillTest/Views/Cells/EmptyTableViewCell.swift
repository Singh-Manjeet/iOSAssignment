//
//  EmptyTableViewCell.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit

private struct Design {
    static let errorMessage = "No data available, Please try again"
    static let cellPadding: CGFloat = 13.0
}

class EmptyTableViewCell: UITableViewCell, Reusable {
    // MARK: - Vars
    private var titleLabel: UILabel!
    
    // MARK: - init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViewsAndlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addSubViewsAndlayout() {
        titleLabel = UILabel(frame: .zero)
        titleLabel.text = Design.errorMessage
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().offset(Design.cellPadding)
            make.bottom.equalToSuperview().offset(-Design.cellPadding)
        }
    }
}
