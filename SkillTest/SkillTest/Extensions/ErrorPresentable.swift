//
//  ErrorPresentable.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation

private struct Design {
    static let errorMessage = "Network Error Occured. Please try again"
}

protocol ErrorPresentable {
    var message: String { get }
}

struct APIError: Error, ErrorPresentable {
    let message: String
    let code: Int
    
    init(message: String? = nil, code: Int) {
        self.message = message ?? Design.errorMessage
        self.code = code
    }
}
