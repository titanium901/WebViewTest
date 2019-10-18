//
//  ViewController.swift
//  WebViewTest
//
//  Created by Yury Popov on 18.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var website = "https://new.faberlic.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupUrl()
        
        
    }
    
    func setupWebView() {
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.navigationDelegate = self
        webView.alpha = 0
    }
    
    func setupUrl() {
        if let url = URL(string: website) {
            webView.load(URLRequest(url: url))
        }
    }
    
}

extension WebViewController: WKUIDelegate {

}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        self.webView.alpha = 0
    }
    
    //удаляем хедер и всплывающий элемент используя document.getElementsByClassName
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        let elementClassName = ["onboarding-trigger js-onboarding-trigger d-flex j-content-center a-items-center", "layout-header js-layout-header fixed-top "]

        for className in elementClassName {
            let removeElementClassScript = "var element = document.getElementsByClassName('\(className)') [0]; element.parentNode.removeChild(element);"
            webView.evaluateJavaScript(removeElementClassScript) { (response, error) in
                       debugPrint("Am here2")
                   }
        }
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.webView.alpha = 1
        }
        
    }
    
}

