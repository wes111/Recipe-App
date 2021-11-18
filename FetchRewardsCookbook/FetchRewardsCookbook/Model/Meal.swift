//
//  Meal.swift
//  FetchRewardsCookbook
//
//  Created by Wesley Luntsford on 11/10/21.
//

import Foundation

class Meal {
    let id: String
    let name: String
    var instructions: String? = nil
    var ingredients: [String] = []
    var measurements: [String] = []
    
    init(with id: String, and name: String) {
        self.id = id
        self.name = name
    }
}
