//
//  Reusable.swift
//  SkillTest
//
//  Created by Manjeet Singh on 30/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func dequeueReusableCell<T: Reusable>(indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderFooterView<T: Reusable>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
