//
//  Fact.swift
//  SkillTest
//
//  Created by Manjeet Singh on 29/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation

struct Country: Codable {
    let title: String?
    let facts: [Fact]?
}

struct Fact: Codable {
    let title: String?
    let description: String?
    let imageHref: String?
}
