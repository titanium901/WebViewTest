//
//  WebViewController+WKNavigationDelegate.swift
//  WebViewTest
//
//  Created by Yury Popov on 19.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation
import WebKit

// Работа с webView
extension WebViewController: WKNavigationDelegate {

    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        self.webView.alpha = 0
        if !isMenuShowing {
            animateSlideMenu()
        }
        
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
    
    // Удаляем хедер и всплывающий элемент используя document.getElementsByClassName
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
        if webView.isLoading {
            return
        }
 
        let elementClassName = ["onboarding-trigger js-onboarding-trigger d-flex j-content-center a-items-center", "layout-header js-layout-header fixed-top ", "header row", "stub__logo", "city-default__confirm btn fs-14 js-popover-close", "header__down container-fluid", "container", "menu"]

        for className in elementClassName {
            let removeElementClassScript = "var element = document.getElementsByClassName('\(className)') [0]; element.parentNode.removeChild(element);"
            webView.evaluateJavaScript(removeElementClassScript) { [weak self] (response, error) in
                if className == "menu" {
                    self?.refreshWebView()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        UIView.animate(withDuration: 1) { [weak self] in
                            self?.activityIndicator.stopAnimating()
                            self?.activityIndicator.isHidden = true
                            self?.webView.alpha = 1
                            
                        }
                    }
                }
            }
            
        }
    }
    
    
    
}

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        let configuration = WKWebViewConfiguration()
        configuration.suppressesIncrementalRendering = true
        return WKWebView(frame: webView.frame, configuration: configuration)
    }
}
