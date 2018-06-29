//
//  FactsViewModel.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation

final class FactsViewModel {
    private var country: Country?
    
    func fetchData() {
        
        APIClient.getFacts(url: Constants.baseUrl) { [weak self] (isSuccessful, country) in
            guard let country = country,
                  isSuccessful,
                  let strongSelf = self else { return }
            
            strongSelf.country = country
        }
    }
    
    var title: String {
        return country?.title ?? ""
    }
}
