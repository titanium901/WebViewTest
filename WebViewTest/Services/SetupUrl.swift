//
//  SetupUrl.swift
//  WebViewTest
//
//  Created by Yury Popov on 18.10.2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation
import WebKit

class SetupUrl {
    
    static let shared = SetupUrl()
    
    func setupUrl(stringUrl: String, webView: WKWebView) {
        if let url = URL(string: stringUrl) {
            webView.load(URLRequest(url: url))
        }
    }
}


