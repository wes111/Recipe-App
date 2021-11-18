//
//  TitleViewController.swift
//  FetchRewardsCookbook
//
//  Created by Wesley Luntsford on 11/11/21.
//

import UIKit

class TitleViewController: UIViewController {

    var recipeFetcher: RecipeFetcher?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recipeFetcher = RecipeFetcher()
        self.performSegue(withIdentifier: K.SegueID.showRecipes, sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.SegueID.showRecipes {
            let recipesVC = segue.destination as! RecipeBrowserViewController
            recipesVC.recipeFetcher = self.recipeFetcher
        }
    }

}
