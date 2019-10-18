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
    var isMove = false
    
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
            menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MenuViewController") as! MenuViewController
            view.insertSubview(menuViewController.view, at: 0)
            addChild(menuViewController)
        }
    }
    
    func showMenuViewController(shouldMove: Bool) {
        if shouldMove {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = self.controller.view.frame.width - 140
            }) { (finished) in
                
            }
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = 0
            }) { (finished) in
                
            }
        }
    }

}

extension ContainerViewController: WebViewControllerDelegate {
    func toggleMenu() {
        configureMenuViewController()
        isMove = !isMove
        showMenuViewController(shouldMove: isMove)
    }
    
    
}
