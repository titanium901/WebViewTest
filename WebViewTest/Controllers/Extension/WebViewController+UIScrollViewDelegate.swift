//
//  WebViewController+UIScrollViewDelegate.swift
//  WebViewTest
//
//  Created by Yury Popov on 19.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation
import WebKit

//Работа со скролом, анимируем и скрываем лого
extension WebViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
          lastContentOffset = scrollView.contentOffset.y
       }

       func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMenuShowing {
            showSlideMenu()
        }
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
