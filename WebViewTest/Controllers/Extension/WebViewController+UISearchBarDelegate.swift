//
//  WebViewController+UISearchBarDelegate.swift
//  WebViewTest
//
//  Created by Yury Popov on 19.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation
import UIKit

//работа с поиском
extension WebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        SetupUrl.shared.setupUrl(stringUrl: "https://faberlic.com/index.php?searchword=\(text)&ordering=&searchphrase=all&option=com_search&lang=ru", webView: webView, completionHandler: nil)
        showSlideMenu()
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}
