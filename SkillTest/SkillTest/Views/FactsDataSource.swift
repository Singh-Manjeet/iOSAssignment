//
//  FactsDataSource.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Data Container
struct FactsContainer {
    let facts: [Fact]
}

// MARK: - Cell Type
enum FactsCellType {
    case facts(Fact)
    case empty
    case loading
}

// MARK: - DataSource Protocol
protocol FactsDataSourceProtocol {
    var state: ViewControllerAPIDataState<FactsContainer> { get set }
    func cellType(at indexPath: IndexPath) -> FactsCellType
}

typealias ViewControllerAPIDataState<T> = DataState<T, APIError>
// MARK: - View Controller DataSource
class FactsDataSource: NSObject, UITableViewDataSource, FactsDataSourceProtocol {
    
    // MARK: - Vars
    var cellTypes: [FactsCellType] = []
    var state: ViewControllerAPIDataState<FactsContainer>  = .loading {
        didSet {
            cellTypes = buildCellTypes()
        }
    }
    
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
        //TODO: fact cell, loading cell, empty cell
        let cellAtIndex = cellType(at: indexPath)
        
        switch cellAtIndex {
        case .loading: break
        case .facts: break
        case .empty: break
        }
        
        return UITableViewCell()
    }
}

// MARK: - Cell Builder
extension FactsDataSource {
    func buildCellTypes() -> [FactsCellType] {
        
        switch state {
        case .loaded(let container):
            cellTypes.removeAll()
            
            guard !container.facts.isEmpty else {
                cellTypes.append(.empty)
                return cellTypes
            }
            
            for fact in container.facts {
                let cellType = FactsCellType.facts(fact)
                cellTypes.append(cellType)
            }
        case .loading:
            cellTypes.append(.loading)
        case .error:
            cellTypes.removeAll()
            cellTypes.append(.empty)
        }
        
        return cellTypes
    }
}
