//
//  MenuViewController.swift
//  WebViewTest
//
//  Created by Yury Popov on 18.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var listStackView: UIStackView!
    @IBOutlet weak var mainToProductConstraint: NSLayoutConstraint!
    @IBOutlet weak var openListButton: UIButton!
    
    var isOpen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func openListButtonAction(_ sender: UIButton) {
        
        isOpen.toggle()
        if !isOpen {
            mainToProductConstraint.constant = 8
        } else {
            mainToProductConstraint.constant = 406
        }
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        
        
        
    }
    
}
