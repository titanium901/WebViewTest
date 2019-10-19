//
//  ViewController.swift
//  WebViewTest
//
//  Created by Yury Popov on 18.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate {
    func toggleMenu()
}

class WebViewController: UIViewController {

    //MARK: -IBOutlet
    @IBOutlet weak var listStackView: UIStackView!
    @IBOutlet weak var mainToProductConstraint: NSLayoutConstraint!
    @IBOutlet weak var openListButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var sideBarLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: -Properties
    private var lastContentOffset: CGFloat = 10
    private var website = "https://new.faberlic.com/"
    var delegate: WebViewControllerDelegate?
    
    var isMenuShowing = false
    var isOpen = true
    
    //MARK: -VieDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        SetupUrl.shared.setupUrl(stringUrl: website, webView: webView)
        webView.scrollView.delegate = self
        searchBar.delegate = self
        showSlideMenu()

        
    }
    
    //MARK: -IBActions
    
    @IBAction func openListButtonAction(_ sender: UIButton) {
       animateMenu()
    }
    @IBAction func backAction(_ sender: UIButton) {
        webView.goBack()
    }
    
    @IBAction func menuButton(_ sender: UIButton) {
        showSlideMenu()
    }
    
    @IBAction func catalogActionButton(_ sender: UIButton) {
        SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/catalog/flash", webView: webView)
    }
    
    @IBAction func bagActionButton(_ sender: UIButton) {
        SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/cart", webView: webView)
    }
    
    @IBAction func registerActionButton(_ sender: UIButton) {
        SetupUrl.shared.setupUrl(stringUrl: "https://faberlic.com/index.php?option=com_flform&idform=514&lang=ru", webView: webView)
    }
    

    
    
    //MARK: -SlideMenu IBActions
    @IBAction func listActionButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/1?q=%3Arelevance%3Ashields%3Anew", webView: webView)
        case 2:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/cosmetics", webView: webView)
        case 3:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/perfumery", webView: webView)
        case 4:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/clothes-and-accessories", webView: webView)
        case 5:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/health", webView: webView)
        case 6:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/everything-for-home", webView: webView)
        case 7:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/goods-for-kids", webView: webView)
        case 8:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/for-men", webView: webView)
        case 9:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/for-business", webView: webView)
        case 10:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/1?q=%3Arelevance%3Ashields%3Apromo", webView: webView)
        case 11:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/", webView: webView)
            showSlideMenu()
        default:
            break
        }
        
    }
    
    //MARK: -UITapGestureRecognizer
    @IBAction func productLabelGestureOnTap(_ sender: UITapGestureRecognizer) {
        animateMenu()
    }
    @IBAction func tapOnLogoGest(_ sender: UITapGestureRecognizer) {
        SetupUrl.shared.setupUrl(stringUrl: website, webView: webView)
        if !isMenuShowing {
            showSlideMenu()
        }
    }
    
 
    //MARK: -Methods
    func animateMenu() {
        isOpen.toggle()
               if !isOpen {
                   mainToProductConstraint.constant = 8
                   listStackView.isUserInteractionEnabled = false
                   openListButton.setTitle("▷", for: .normal)
               } else {
                   mainToProductConstraint.constant = 406
                   listStackView.isUserInteractionEnabled = true
                   openListButton.setTitle("▽", for: .normal)
               }
               UIView.animate(withDuration: 1) {
                   self.view.layoutIfNeeded()
                   self.listStackView.alpha = self.isOpen ? 1 : 0
               }
    }
    
    func showSlideMenu() {
        if isMenuShowing {
            sideBarLeadingConstraint.constant = 0
        } else {
            sideBarLeadingConstraint.constant = -230
        }
        isMenuShowing.toggle()
        slideView.isUserInteractionEnabled = !isMenuShowing
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
            
        }
    }
    
    func setupUI() {
        backButton.isHidden = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.navigationDelegate = self
        webView.alpha = 0
    }
    
    func setupUrl(stringUrl: String) {
        if let url = URL(string: stringUrl) {
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
        
        let elementClassName = ["onboarding-trigger js-onboarding-trigger d-flex j-content-center a-items-center", "layout-header js-layout-header fixed-top ", "header row", "stub__logo"]
        
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

extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        SetupUrl.shared.setupUrl(stringUrl: "https://faberlic.com/index.php?searchword=\(text)&ordering=&searchphrase=all&option=com_search&lang=ru", webView: webView)
        showSlideMenu()
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}


