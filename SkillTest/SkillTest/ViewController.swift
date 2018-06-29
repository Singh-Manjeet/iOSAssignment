//
//  ViewController.swift
//  SkillTest
//
//  Created by Manjeet Singh on 29/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        //temporary api call
        APIClient.getFacts(url: Constants.baseUrl) { (isSuccessful, country) in
            print(country)
        }
    }
}

