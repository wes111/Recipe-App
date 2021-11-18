//
//  RecipeFetcher.swift
//  FetchRewardsCookbook
//
//  Created by Wesley Luntsford on 11/9/21.
//

import Foundation

class RecipeFetcher {
    
    let decoder = JSONDecoder()
    var categories: [String] = []
    // Outer array contains one inner array for each meal category.
    var allMeals: [[Meal]] = [[]]
    
    init() {
        setupCategories()
        setupMeals()
    }
    
    // Appends all categories to the categories array.
    func setupCategories() {
        if let categoriesData = request(using: K.DatabaseAPI.completeCategoriesURL) {
            parseCategoryJSON(using: categoriesData)
        }
        categories.sort()
    }
    
    // Appends each meal to allMeals.
    func setupMeals() {
        for (index, category) in categories.enumerated() {
            allMeals.append([]) // Initial empty list of meals for each category.
            let completeMealsURL = "\(K.DatabaseAPI.partialMealsURL)\(category)"
            if let mealsData = request(using: completeMealsURL) {
                parseMealsJSON(using: mealsData, index)
            }
        }
    }
    
    // Appends array of ingredients and measurements to each meal.
    func setupMealDetails(for meal: Meal) {
        let completeMealDetailsURL = "\(K.DatabaseAPI.partialMealDetailsURL)\(meal.id)"
        if let mealDetailsData = request(using: completeMealDetailsURL) {
            parseMealDetailsJSON(using: mealDetailsData, meal)
        }
    }
    
    func request(using urlString: String) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        var requestedData: Data? = nil
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let unwrappedData = data {
                    requestedData = unwrappedData
                    semaphore.signal()
                } else {
                    print("Error receiving data from URL.")
                }
            }
            task.resume()
        }
        // Wait for closure to complete before returning data.
        semaphore.wait()
        return requestedData
    }
    
    func parseCategoryJSON(using data: Data) {
        do {
            let decodedData = try decoder.decode(CategoryData.self, from: data)
            for index in 0..<decodedData.categories.count {
                categories.append(decodedData.categories[index].strCategory)
            }
        } catch {
            print(error)
        }
    }
    
    func parseMealsJSON(using data: Data, _ categoryIndex: Int) {
        do {
            let decodedData = try decoder.decode(MealsData.self, from: data)
            for index in 0..<decodedData.meals.count {
                let id = decodedData.meals[index].idMeal
                let name = decodedData.meals[index].strMeal
                let meal = Meal(with: id, and: name)
                allMeals[categoryIndex].append(meal)
            }
        } catch {
            print(error)
        }
    }
    
    func parseMealDetailsJSON(using data: Data, _ meal: Meal) {
        do {
            let decodedData = try decoder.decode(MealDetailsData.self, from: data)
            meal.instructions = decodedData.meals[0].strInstructions
            meal.ingredients.append(contentsOf:
                decodedData.meals[0].combineIngredients())
            meal.measurements.append(contentsOf: decodedData.meals[0].combineMeasurements())
        } catch {
            print(error)
        }
    }
}
