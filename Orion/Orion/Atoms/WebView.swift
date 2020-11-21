//
//  WebView.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    let width: CGFloat
    let height: CGFloat
    let htmlName: String

    func makeNSView(context _: NSViewRepresentableContext<WebView>) -> WKWebView {
        WKWebView()
    }

    func updateNSView(_ webview: WKWebView, context _: NSViewRepresentableContext<WebView>) {
        if webview.url == nil {
            let path = Bundle.main.path(forResource: htmlName, ofType: "html")!
            let url = URL(fileURLWithPath: path)
            do {
                let contents = try String(contentsOf: url, encoding: .utf8)
                webview.loadHTMLString(contents, baseURL: nil)
            } catch {}
            return
        }
        DispatchQueue.main.async {
            webview.setFrameSize(NSSize(width: width, height: height))
        }
    }
}
