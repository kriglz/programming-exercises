//
//  WebViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 10/10/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    var webURL: URL?
    
    var webView: WKWebView! 
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myRequest = URLRequest(url: webURL!)
        webView?.load(myRequest)
    }
}
