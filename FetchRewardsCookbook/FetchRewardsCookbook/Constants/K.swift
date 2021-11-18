//
//  K.swift
//  FetchRewardsCookbook
//
//  Created by Wesley Luntsford on 11/11/21.
//

import Foundation

// Constants file
struct K {
    struct SegueID {
        static let showMeal = "showMeal"
        static let showRecipes = "showRecipes"
    }
    
    struct CellID {
        static let ingredientCell = "ingredientCell"
        static let mealCell = "mealCell"
    }
    
    struct DatabaseAPI {
        static let completeCategoriesURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
        static let partialMealsURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
        static let partialMealDetailsURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    }
}
