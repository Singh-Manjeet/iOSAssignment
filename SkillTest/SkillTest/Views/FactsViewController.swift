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
import NVActivityIndicatorView

// MARK: - Design Constants
private struct Design {
    static let estimatedTableViewCellHeight: CGFloat = 400.0
    
    struct Loading {
        static let fetchData: String = "Loading Data.."
    }
    
    struct LoadingAnimation {
        static let height: CGFloat = 100.0
        static let width: CGFloat = 100.0
        static let xPosition: CGFloat = UIScreen.main.bounds.width / 2 - Design.LoadingAnimation.width / 2
        static let yPosition: CGFloat = UIScreen.main.bounds.height / 2 - Design.LoadingAnimation.height / 2
        
        static let frame: CGRect = CGRect(x: Design.LoadingAnimation.xPosition,
                                          y: Design.LoadingAnimation.yPosition,
                                          width: Design.LoadingAnimation.width,
                                          height: Design.LoadingAnimation.height)
    }
}

class FactsViewController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - Vars
    private var tableView: UITableView!
    private var dataSource: FactsDataSource!
    private var viewModel: FactsViewModel!
    
    var refreshControl = UIRefreshControl()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLoadingAnimation(withMessage: Design.Loading.fetchData)
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
}

// MARK: - Privates
private extension FactsViewController {
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.estimatedRowHeight = Design.estimatedTableViewCellHeight
        tableView.separatorInset = .zero
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.sendSubview(toBack: refreshControl)
        
        refreshControl.addTarget(self, action:
            #selector(type(of: self).didReloadRefreshControl(_:)), for: UIControlEvents.valueChanged)
        
        //tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.sectionFooterHeight = CGFloat.leastNonzeroMagnitude
        
        //constraints
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupDataSource() {
        viewModel = FactsViewModel(delegate: self)
        dataSource = FactsDataSource(for: tableView)
    }
    
    func startLoadingAnimation(withMessage message: String) {
        let activityIndicatorView = NVActivityIndicatorView(frame: Design.LoadingAnimation.frame,
                                                            type: NVActivityIndicatorType.lineScale)
        self.view.addSubview(activityIndicatorView)
        startAnimating(CGSize(width: activityIndicatorView.frame.width,
                              height: activityIndicatorView.frame.height),
                       message: message,
                       type: NVActivityIndicatorType.lineScale)
        
    }
    
    func setNavigationTitle() {
        navigationItem.title = viewModel.title
    }
    
    func presentError(with message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    @objc func didReloadRefreshControl(_ sender: UIRefreshControl) {
        fetchData()
    }
    
    func fetchData() {
        viewModel.fetchData()
    }
}

// MARK: - FactsViewModelDelegate
extension FactsViewController: FactsViewModelDelegate {
    func stateDidChange(_ state: ViewControllerAPIDataState<FactsContainer>) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.stopAnimating()
            strongSelf.refreshControl.endRefreshing()
            strongSelf.dataSource.state = state
            
            switch state {
            case .loaded:
                strongSelf.setNavigationTitle()
            case .error(let error):
                strongSelf.presentError(with: error.message)
            default: break
            }
            
            strongSelf.tableView.reloadData()
            strongSelf.tableView.layoutIfNeeded()
        }
    }
}

extension FactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
