//
//  CategoryViewController.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/3/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var navItem: UINavigationItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        navItem.title = "Family History: A Primer"
    }
}
