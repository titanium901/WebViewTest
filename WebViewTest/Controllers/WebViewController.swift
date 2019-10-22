//
//  ViewController.swift
//  WebViewTest
//
//  Created by Yury Popov on 18.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import WebKit
import SwiftSoup

class WebViewController: UIViewController {

    // MARK: -IBOutlet
    // ProductSlideMenu properties
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var openProductButton: UIButton!
    
    @IBOutlet weak var openMenuButton: UIButton!
    @IBOutlet weak var slideScrollViewLeadingConst: NSLayoutConstraint!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var scrollSlideView: UIScrollView!
    @IBOutlet weak var slideViewLeadingConst: NSLayoutConstraint!
    
  
    @IBOutlet weak var slideViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var productStackView: UIStackView!
    @IBOutlet weak var productHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var companyStackView: UIStackView!
    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var servisStackView: UIStackView!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var underServiceView: UIView!
    @IBOutlet weak var lastView: UIView!
    
    
    
    // MARK: -Properties
    private var website = "https://new.faberlic.com/ru/"
    var lastContentOffset: CGFloat = 10
    var isMenuShowing = false
    var isOpenProductMenu = true
    var isOpenMainMenu = true
    private var trayOriginalCenter: CGPoint!
    private var trayRight: CGPoint!
    
    // MARK: -VieDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateSlideMenu()
        trayRight = scrollSlideView.center
        animateProductMenu()
        animateMainMenu()
        
        let scrollViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        scrollViewPanGesture.delegate = self
        scrollSlideView.addGestureRecognizer(scrollViewPanGesture)
        trayOriginalCenter = scrollSlideView.center

        
    }
    
    // MARK: -IBActions
    @IBAction func openProductButtonAction(_ sender: UIButton) {
        animateProductMenu()
    }
    @IBAction func openMenuButtonAction(_ sender: UIButton) {
        animateMainMenu()
    }

    @IBAction func backAction(_ sender: UIButton) {
        webView.goBack()
    }
    
    @IBAction func menuButton(_ sender: UIButton) {
        animateSlideMenu()
        
    }
    
    @IBAction func catalogActionButton(_ sender: UIButton) {
        SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/catalog/flash", webView: webView, completionHandler: nil)
    }
    
    @IBAction func bagActionButton(_ sender: UIButton) {
        SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/cart", webView: webView, completionHandler: nil)
    }
    
    // Попробывал распарсить сайт и удалить лишнее через swiftSoup
    @IBAction func registerActionButton(_ sender: UIButton) {
        SetupUrl.shared.setupUrl(stringUrl: "https://faberlic.com/index.php?option=com_flform&idform=514&lang=ru", webView: webView) { finish in
        }
        
//        let myURLAdress = "https://faberlic.com/index.php?option=com_flform&idform=514&lang=ru"
//        guard let myURL = URL(string: myURLAdress) else { return }
//        
//        let URLTask = URLSession.shared.dataTask(with: myURL) { myData, response, error in
//            
//            guard error == nil else { return }
//            guard let data = myData else { return }
//            let myHTMLString = String(data: data, encoding: String.Encoding.utf8)
//            
//            do {
//                var html = myHTMLString ?? ""
//                let doc: Document = try SwiftSoup.parse(html)
//                try doc.select("header").remove()
//                try html = doc.outerHtml()
//                DispatchQueue.main.async { [weak self] in
//                    self?.webView.loadHTMLString(html, baseURL: nil)
//                }
//                
//            } catch Exception.Error(let type, let message) {
//                print(type)
//                print(message)
//            } catch {
//                print("error")
//            }
//        }
//        URLTask.resume()
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
            case 12:
            SetupUrl.shared.setupUrl(stringUrl: "https://faberlic.com/index.php?option=com_content&view=category&layout=blog&id=379", webView: webView, completionHandler: nil)
            case 13:
            SetupUrl.shared.setupUrl(stringUrl: "https://faberlic.com/index.php?option=com_list&view=list&listId=104", webView: webView, completionHandler: nil)
            case 14:
            SetupUrl.shared.setupUrl(stringUrl: "https://faberlic.com/index.php?Itemid=2356", webView: webView, completionHandler: nil)
            case 15:
            SetupUrl.shared.setupUrl(stringUrl: "https://new.faberlic.com/ru/catalog/flash", webView: webView, completionHandler: nil)
        default:
            break
        }
        
    }

    
    // MARK: -UITapGestureRecognizer
    @IBAction func productLabelGestureOnTap(_ sender: UITapGestureRecognizer) {
        animateProductMenu()
    }
    @IBAction func tapOnLogoGest(_ sender: UITapGestureRecognizer) {
        SetupUrl.shared.setupUrl(stringUrl: website, webView: webView, completionHandler: nil)
        if !isMenuShowing {
            animateSlideMenu()
        }
    }
    
    @objc func onPan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        if sender.state == UIGestureRecognizer.State.began {
            
            trayRight = scrollSlideView.center
        } else if sender.state == UIGestureRecognizer.State.changed {
            if translation.x >= 0.0 {
                scrollSlideView.center = CGPoint(x: trayRight.x, y: trayRight.y)
            } else {
                
                scrollSlideView.center = CGPoint(x: trayRight.x + translation.x, y: trayRight.y)
            }
            
        } else if sender.state == UIGestureRecognizer.State.ended {
            
            if scrollSlideView.center.x > trayRight.x - 30 {
                
            } else {
                animateSlideMenu()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.scrollSlideView.center.x = self.trayOriginalCenter.x
                }
            }
        }
    }
    
    
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
//        animateSlideMenu()
    }
    
    
 
    // MARK: -Methods
    // Анимация списка внутри sideMenu
    func animateProductMenu() {
        if isOpenProductMenu {
            productStackView.isUserInteractionEnabled = false
            productHeightConst.constant = 8
            openProductButton.setTitle("▷", for: .normal)
        } else {
            productStackView.isUserInteractionEnabled = true
            productHeightConst.constant = 406
            openProductButton.setTitle("▽", for: .normal)
        }
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.productStackView.alpha = self.isOpenProductMenu ? 0 : 1
        }
        isOpenProductMenu.toggle()
    }
    func animateMainMenu() {
        if isOpenMainMenu {
            openMenuButton.setTitle("▷", for: .normal)
            companyStackView.isUserInteractionEnabled = false
            brandView.isUserInteractionEnabled = false
            servisStackView.isUserInteractionEnabled = false
            serviceView.isUserInteractionEnabled = false
            underServiceView.isUserInteractionEnabled = false
            lastView.isUserInteractionEnabled = false
        } else {
            openMenuButton.setTitle("▽", for: .normal)
            companyStackView.isUserInteractionEnabled = true
            brandView.isUserInteractionEnabled = true
            servisStackView.isUserInteractionEnabled = true
            serviceView.isUserInteractionEnabled = true
            underServiceView.isUserInteractionEnabled = true
            lastView.isUserInteractionEnabled = true
        }
        
        UIView.animate(withDuration: 1) {
            self.companyStackView.alpha = self.isOpenMainMenu ? 0 : 1
            self.brandView.alpha = self.isOpenMainMenu ? 0 : 1
            self.servisStackView.alpha = self.isOpenMainMenu ? 0 : 1
            self.serviceView.alpha = self.isOpenMainMenu ? 0 : 1
            self.underServiceView.alpha = self.isOpenMainMenu ? 0 : 1
            self.lastView.alpha = self.isOpenMainMenu ? 0 : 1
            self.scrollSlideView.isScrollEnabled = !self.isOpenMainMenu ? true : false
            
        }
        
        isOpenMainMenu.toggle()
    }
    
    // Показать/убрать slide menu
    func animateSlideMenu() {
        print(slideScrollViewLeadingConst.constant)
        slideScrollViewLeadingConst.constant = isMenuShowing ? 0 : -300
        slideViewLeadingConst.constant = isMenuShowing ? 0 : -300
        
        isMenuShowing.toggle()
        scrollSlideView.isUserInteractionEnabled = !isMenuShowing
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
            self.menuButton.transform = CGAffineTransform(rotationAngle: !self.isMenuShowing ? CGFloat(Double.pi/2) : CGFloat(Double.pi))
            self.slideView.alpha = self.isMenuShowing ? 0 : 1
            self.scrollSlideView.alpha = self.isMenuShowing ? 0 : 1
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
        print(#function)
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

extension WebViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

