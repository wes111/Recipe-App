//
//  CategoryData.swift
//  FetchRewardsCookbook
//
//  Created by Wesley Luntsford on 11/9/21.
//

import Foundation

struct CategoryData: Decodable {
    let categories: [Categories]
}

struct Categories: Decodable {
    let strCategory: String
}
