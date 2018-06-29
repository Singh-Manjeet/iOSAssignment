//
//  ErrorPresentable.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation

protocol ErrorPresentable {
    var message: String { get }
}

struct APIError: Error, ErrorPresentable {
    let message: String
    let code: Int
    
    init(message: String? = nil, code: Int) {
        self.message = message ?? "Network Error Occured. Please try again"
        self.code = code
    }
}
