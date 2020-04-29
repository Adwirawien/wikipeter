//
//  WebView.swift
//  Wikipeter
//
//  Created by Adrian Böhme on 29.04.20.
//  Copyright © 2020 Adrian Böhme. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var request: URLRequest

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(request)
        webView.isUserInteractionEnabled = true
        webView.scrollView.isScrollEnabled = false
        
        Remover().removeContents(webView: webView)
    }
}

class Remover {
    func removeContents(webView: WKWebView) {
        Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(executeJS(timer:)), userInfo: ["view": webView], repeats: false)
    }
    
    @objc func executeJS(timer: Timer) {
        guard let context = timer.userInfo as? [String: WKWebView] else { return }
        let webView = context["view"]
        webView?.customUserAgent = "Mozilla/5.0 (iPad; CPU iPhone OS 12_1_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1"
        
        if (webView!.isLoading) {
            removeContents(webView: webView!)
            return
        }
        
        let removeElementIdScript = "document.getElementsByTagName('header')[0].innerHTML = ''; document.getElementsByTagName('footer')[0].innerHTML = ''; document.getElementsByClassName('page-actions-menu')[0].innerHTML = '';"
        webView!.evaluateJavaScript(removeElementIdScript) { (response, error) in
            //debugPrint(error)
        }
    }
}
