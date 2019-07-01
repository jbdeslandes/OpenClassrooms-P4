//
//  ViewController.swift
//  P4 - Instagrid
//
//  Created by Jean-Baptiste Deslandes on 23/06/2019.
//  Copyright © 2019 Jean-Baptiste Deslandes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        grid = .layout2
    }
    
    // MARK: - Properties
    
    var grid: Grid = .layout2 {
        didSet {
            displayDidChange()
        }
    }
    
    // MARK: - Methods
    
    func displayDidChange() {
        for i in 0..<contentViews.count {
            let value = grid.display[i]
            contentViews[i].isHidden = value
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet var contentViews: [UIView]!
    @IBOutlet var patternButtons: [UIButton]!
    
    // MARK: - Actions
    
    @IBAction func patternButtonTapped(_ sender: UIButton) {
        patternButtons.forEach { $0.isSelected = false }
        sender.isSelected = true
        switch sender.tag {
        case 0:
            grid = .layout1
        case 1:
            grid = .layout2
        case 2:
            grid = .layout3
        default:
            break
        }
    }
    
}

