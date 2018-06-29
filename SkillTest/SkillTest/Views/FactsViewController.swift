//
//  FactsViewController.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

// MARK: - Design Constants
private struct Design {
    static let estimatedTableViewCellHeight: CGFloat = 100.0
    
    struct Loading {
        static let fetchData: String = "Loading Data.."
    }
}

class FactsViewController: UIViewController {
    
    // MARK: - Vars & IBOutlets
    private var dataSource: FactsDataSource!
    private var viewModel: FactsViewModel!
    private var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupDataSource()
    }
}

// MARK: - Privates
private extension FactsViewController {
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Design.estimatedTableViewCellHeight
        tableView.separatorInset = .zero
        tableView.addSubview(refreshControl)
        tableView.sendSubview(toBack: refreshControl)
        
        refreshControl.addTarget(self, action:
            #selector(type(of: self).didReloadRefreshControl(_:)), for: UIControlEvents.valueChanged)
        
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.sectionFooterHeight = CGFloat.leastNonzeroMagnitude
    }
    
    func setupDataSource() {
        viewModel = FactsViewModel(delegate: self)
        dataSource = FactsDataSource(for: tableView)
        navigationItem.title = viewModel.title
        viewModel.fetchData()
    }
    
    func presentError(with message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    @objc func didReloadRefreshControl(_ sender: UIRefreshControl) {
        viewModel.fetchData()
    }
}

// MARK: - FactsViewModelDelegate
extension FactsViewController: FactsViewModelDelegate {
    func stateDidChange(_ state: ViewControllerAPIDataState<FactsContainer>) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
        
        switch state {
        case .loaded:
            dataSource.state = state
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .error(let error):
            presentError(with: error.message)
        default:
            break
        }
    }
}
