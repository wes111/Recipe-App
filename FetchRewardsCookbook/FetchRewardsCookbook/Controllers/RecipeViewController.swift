//
//  RecipeViewController.swift
//  FetchRewardsCookbook
//
//  Created by Wesley Luntsford on 11/10/21.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: K.CellID.ingredientCell)
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        recipeLabel!.text = meal?.name
        instructionsLabel.text = meal?.instructions
    }
}

// MARK: - TableViewDataSource
extension RecipeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (meal?.ingredients.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createIngredientCell(for: indexPath, tableView)
    }
    
    func createIngredientCell(for indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: K.CellID.ingredientCell, for: indexPath)
        let label = cell.textLabel!
        if let ingredient = meal?.ingredients[indexPath.row],
           let measurement = meal?.measurements[indexPath.row] {
            label.text = "\(ingredient): (\(measurement))"
        }
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return cell
    }
}

// MARK: - TableViewDelegate
extension RecipeViewController: UITableViewDelegate {
    
}

// MARK: - ScrollViewDelegate
extension RecipeViewController: UIScrollViewDelegate {
    
}

