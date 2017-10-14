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
    var progressView = UIProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: self.view.frame)
        let myRequest = URLRequest(url: webURL!)
        webView.load(myRequest)
        webView.navigationDelegate = self
        view = webView
        
        //progress monitor
        progressView = UIProgressView(progressViewStyle: .default)
        progressView = UIProgressView(frame: CGRect(origin: CGPoint.init(x: 0, y: 64), size: CGSize(width: self.view.frame.width, height: 50.0)))
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress) , options: .new, context: nil)
        webView.addSubview(progressView)
        
        webView.uiDelegate = self
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = webView.title
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if !(navigationAction.targetFrame?.isMainFrame != nil) {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
        
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            self.progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
        
        if self.progressView.progress >= 1.0 {
            UIView.animate(withDuration: 0.3,
                           delay: 0.1,
                           options: .curveEaseIn,
                           animations:
                {() -> Void in self.progressView.alpha = 0.0},
                           completion:
                {(finished: Bool) -> Void in self.progressView.alpha = 0.0})
        }
    }
}
