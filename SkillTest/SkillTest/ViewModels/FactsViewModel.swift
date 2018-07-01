//
//  FactsViewModel.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation

private struct Design {
    static let noTitle = "Anonymous"
    static let noInternet = "Please check your internet and try again."
}

// MARK: - FactsViewModelDelegate
protocol FactsViewModelDelegate: class {
    func stateDidChange(_ state: ViewControllerAPIDataState<FactsContainer>)
}

final class FactsViewModel {
    private var country: Country?
    weak var delegate: FactsViewModelDelegate?
    
    // MARK: - LifeCycle
    init(delegate: FactsViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    private(set) var state: ViewControllerAPIDataState<FactsContainer> = .loading {
        didSet {
            delegate?.stateDidChange(state)
        }
    }
    
    //MARK: - To Demonstrate
    //Added both ways i.e Delegate pattern as well as Closure to get the response
    func fetchData() {
        guard Reachability.isConnectedToNetwork() else {
            self.state = .error(APIError(message: Design.noInternet, code: 0))
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            APIClient.getFacts(url: APIConstants.baseUrl) { [weak self] (isSuccessful, country) in
                
                guard let country = country,
                    let facts = country.facts,
                    isSuccessful,
                    let strongSelf = self else { return }
                
                strongSelf.country = country
                let container = FactsContainer(facts: facts)
                strongSelf.state = .loaded(container)
            }
        }
    }
    
    //MARK: - Closure: Unit Testing
    func getData(onCompletion: @escaping (_ state: ViewControllerAPIDataState<FactsContainer>) -> Void) {
        func fetchData() {
            guard Reachability.isConnectedToNetwork() else {
                onCompletion(state)
                return
            }
            
            DispatchQueue.global(qos: .background).async {
                APIClient.getFacts(url: APIConstants.baseUrl) { [weak self] (isSuccessful, country) in
                    
                    guard let country = country,
                        let facts = country.facts,
                        isSuccessful,
                        let strongSelf = self else { return }
                    
                    strongSelf.country = country
                    let container = FactsContainer(facts: facts)
                    onCompletion(.loaded(container))
                }
            }
        }
    }
    
    var title: String {
        return country?.title ?? Design.noTitle
    }
}
