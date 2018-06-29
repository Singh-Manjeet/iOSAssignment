//
//  FactsDataSource.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Container
struct FactsContainer {
    let facts: [Fact]
}

// MARK: - Cell Type
enum FactsCellType {
    case facts(Fact)
    case empty
    case loading
}

// MARK: - View Controller DataSource
class FactsDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Vars
    var cellTypes: [FactsCellType] = []
    
    init(for tableView: UITableView) {
        super.init()
        tableView.dataSource = self
    }
    
    func cellType(at indexPath: IndexPath) -> FactsCellType {
        return cellTypes[indexPath.row]
    }
}

// MARK: - TableView DataSource
extension FactsDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO:
        return UITableViewCell()
    }
}
