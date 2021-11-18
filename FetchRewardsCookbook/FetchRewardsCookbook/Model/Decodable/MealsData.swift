//
//  MealsData.swift
//  FetchRewardsCookbook
//
//  Created by Wesley Luntsford on 11/10/21.
//

import Foundation

struct MealsData: Decodable {
    let meals: [Meals]
}

struct Meals: Decodable {
    let strMeal: String
    let idMeal: String
}
