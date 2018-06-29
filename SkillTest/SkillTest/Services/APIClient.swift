//
//  APIClient.swift
//  SkillTest
//
//  Created by Manjeet Singh on 29/6/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 * API Client
 * Fetches the data from API
 */
typealias JSONDictionary = [String:Any]
class APIClient {
    
    static func getFacts(url :URL, onCompletion :@escaping (_ isSuccessful: Bool, _ country: Country?) -> ()) {
        let decoder = JSONDecoder()
        
        // directly used URLSession instead of alamofire as per the requirements
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                onCompletion(false, nil)
                return
            }
            
            //to encode with utf-8
            let responseStrInISO = String(data: data, encoding: String.Encoding.iso2022JP)
            
            guard let modifiedDataInUTF8Format = responseStrInISO?.data(using: String.Encoding.utf8),
                  let json = try? JSON(data: modifiedDataInUTF8Format).dictionary,
                  let factData = try? JSONEncoder().encode(json![APIKeys.facts]),
                  let facts = try? decoder.decode([Fact].self, from: factData),
                  let title = json![APIKeys.title]?.string else {

                    onCompletion(false, nil)
                    return
            }

            let country = Country(title: title, facts: facts)
            onCompletion(true, country)
            }.resume()
    }
}
