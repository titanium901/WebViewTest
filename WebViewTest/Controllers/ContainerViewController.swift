//
//  ContainerViewController.swift
//  WebViewTest
//
//  Created by Yury Popov on 18.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    var controller: UIViewController!
    var menuViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureWebViewController()
    }
    

    func configureWebViewController() {
        let webViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! WebViewController
        webViewController.delegate = self
        controller = webViewController
        view.addSubview(controller.view)
        addChild(controller)
    }
    
    func configureMenuViewController() {
        if menuViewController == nil {
            menuViewController = MenuViewController()
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
        }
    }

}

extension ContainerViewController: WebViewControllerDelegate {
    func toggleMenu() {
        configureMenuViewController()
    }
    
    
}
