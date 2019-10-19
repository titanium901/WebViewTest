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

    // MARK: -IBOutlet
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
    
    // MARK: -Properties
    private var website = "https://new.faberlic.com/ru/"
    var lastContentOffset: CGFloat = 10
    var isMenuShowing = false
    var isOpen = true
    var reload = 0 {
        didSet {
            webView.reload()
        }
    }
    
    // MARK: -VieDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showSlideMenu()
    }
    
    // MARK: -IBActions
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
        SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/catalog/flash", webView: webView, completionHandler: nil)
    }
    
    @IBAction func bagActionButton(_ sender: UIButton) {
        SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/cart", webView: webView, completionHandler: nil)
    }
    
    @IBAction func registerActionButton(_ sender: UIButton) {
        SetupUrl.shared.setupUrl(stringUrl: "https://faberlic.com/index.php?option=com_flform&idform=514&lang=ru", webView: webView) { finish in
        }
        
    }
    
    
    
    // MARK: -SlideMenu IBActions
    @IBAction func listActionButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/1?q=%3Arelevance%3Ashields%3Anew", webView: webView, completionHandler: nil)
        case 2:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/cosmetics", webView: webView, completionHandler: nil)
        case 3:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/perfumery", webView: webView, completionHandler: nil)
        case 4:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/clothes-and-accessories", webView: webView, completionHandler: nil)
        case 5:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/health", webView: webView, completionHandler: nil)
        case 6:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/everything-for-home", webView: webView, completionHandler: nil)
        case 7:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/goods-for-kids", webView: webView, completionHandler: nil)
        case 8:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/for-men", webView: webView, completionHandler: nil)
        case 9:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/for-business", webView: webView, completionHandler: nil)
        case 10:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/c/1?q=%3Arelevance%3Ashields%3Apromo", webView: webView, completionHandler: nil)
        case 11:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/", webView: webView, completionHandler: nil)
            showSlideMenu()
        default:
            break
        }
        
    }
    
    // MARK: -UITapGestureRecognizer
    @IBAction func productLabelGestureOnTap(_ sender: UITapGestureRecognizer) {
        animateMenu()
    }
    @IBAction func tapOnLogoGest(_ sender: UITapGestureRecognizer) {
        SetupUrl.shared.setupUrl(stringUrl: website, webView: webView, completionHandler: nil)
        if !isMenuShowing {
            showSlideMenu()
        }
    }
    
 
    // MARK: -Methods
    // Анимация списка внутри sideMenu
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
    
    // Показать/убрать slide menu
    func showSlideMenu() {
        
        sideBarLeadingConstraint.constant = isMenuShowing ? 0 : -230
        isMenuShowing.toggle()
        slideView.isUserInteractionEnabled = !isMenuShowing
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
            self.menuButton.transform = CGAffineTransform(rotationAngle: !self.isMenuShowing ? CGFloat(Double.pi/2) : CGFloat(Double.pi))
        }
      
    }
    
    // Первичные настройки
    func setupUI() {
        backButton.isHidden = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.navigationDelegate = self
        webView.alpha = 0
        webView.scrollView.delegate = self
        searchBar.delegate = self
        SetupUrl.shared.setupUrl(stringUrl: website, webView: webView, completionHandler: nil)
    }
    
    func refreshWebView() {
        if UserDefaults.isFirstLaunch() {
            print("is first launch")
            webView.stopLoading()
            webView.reload()
        } else {
            print("second launch")
            
        }
    }
}

extension UserDefaults {
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    
}


