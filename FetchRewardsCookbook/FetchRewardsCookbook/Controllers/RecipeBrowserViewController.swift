//
//  ViewController.swift
//  FetchRewardsCookbook
//
//  Created by Wesley Luntsford on 11/9/21.
//

import UIKit

class RecipeBrowserViewController: UITableViewController {
    
    @IBOutlet weak var mealLabel: UILabel!
    var recipeFetcher: RecipeFetcher?
    // Optional meal tapped by the user.
    var selectedMeal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Fetch Rewards' Recipes"
        navigationItem.hidesBackButton = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.SegueID.showMeal {
            let mealVC = segue.destination as! RecipeViewController
            mealVC.meal = selectedMeal
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recipeFetcher!.categories[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return recipeFetcher!.categories.count
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeFetcher!.allMeals[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createMealCell(for: tableView, at: indexPath)
    }
    
    func createMealCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellID.mealCell, for: indexPath)
        let label = cell.textLabel!
        label.text = recipeFetcher!.allMeals[indexPath.section][indexPath.row].name
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeal = recipeFetcher!.allMeals[indexPath.section][indexPath.row]
        // Waits to fetch meal details from database until the meal is tapped.
        recipeFetcher!.setupMealDetails(for: selectedMeal!)
        self.performSegue(withIdentifier: K.SegueID.showMeal, sender: self)
    }
}

