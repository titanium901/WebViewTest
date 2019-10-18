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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    
    private var lastContentOffset: CGFloat = 10
    private var website = "https://new.faberlic.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupUrl()
        self.webView.scrollView.delegate = self
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        webView.goBack()
    }
    
    func setupUI() {
        backButton.isHidden = true
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
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if self.webView.canGoBack {
            UIView.animate(withDuration: 0.5) {
                self.backButton.alpha = 1
                self.backButton.isEnabled = true
                self.backButton.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.backButton.alpha = 0
                self.backButton.isEnabled = false
                self.backButton.isHidden = true
            }
        }
    }
    
    //удаляем хедер и всплывающий элемент используя document.getElementsByClassName
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        let elementClassName = ["onboarding-trigger js-onboarding-trigger d-flex j-content-center a-items-center", "layout-header js-layout-header fixed-top "]
        
        for className in elementClassName {
            let removeElementClassScript = "var element = document.getElementsByClassName('\(className)') [0]; element.parentNode.removeChild(element);"
            webView.evaluateJavaScript(removeElementClassScript) { (response, error) in
                debugPrint("Am here")
            }
        }
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.webView.alpha = 1
        }
        
        
        
    }
    
}

extension WebViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
          lastContentOffset = scrollView.contentOffset.y
       }

       func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(lastContentOffset)
        print(scrollView.contentOffset.y)
        if lastContentOffset > scrollView.contentOffset.y {
               UIView.animate(withDuration: 0.25, animations: { [weak self] in
                   self?.logoImage.alpha = 1.0
                   self?.logoImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
               }, completion: nil)
           } else if lastContentOffset < scrollView.contentOffset.y {
               UIView.animate(withDuration: 0.25, animations: { [weak self] in
                   self?.logoImage.alpha = 0
                   self?.logoImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
               }, completion: nil)
           }
       }
}

