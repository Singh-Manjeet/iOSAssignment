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
    
    func fetchData() {
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
    
    var title: String {
        return country?.title ?? Design.noTitle
    }
}