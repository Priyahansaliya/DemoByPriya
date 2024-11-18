//
//  ConvertHtmlToString.swift
//  SwiftUIAnimation
//
//  Created by Priya Hansaliya on 16/07/24.
//
import SwiftUI
import UIKit
import WebKit

// Main SwiftUI view
struct ConvertHtmlToString: View {
    let htmlString = """
        ousand people have been shifted to secure locations by the rescue and relief tea
        """

    @State private var webViewHeight: CGFloat = .zero

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading) {
                WebView(htmlContent: htmlString, fontSize: 12, height: $webViewHeight)
                    .background(Color.yellow)
                    .frame(height: webViewHeight)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

// Preview
struct ConvertHtmlToString_Previews: PreviewProvider {
    static var previews: some View {
        ConvertHtmlToString()
    }
}

// WebView component
struct WebView: UIViewRepresentable {
    var htmlContent: String
    var fontSize: CGFloat
    @Binding var height: CGFloat
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        loadHTMLContent(webView: webView)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        loadHTMLContent(webView: webView)
    }
    
    private func loadHTMLContent(webView: WKWebView) {
        webView.loadHTMLString(htmlContent, baseURL: nil)
        let jsScript = """
        var style = document.createElement('style');
        style.innerHTML = 'body { font-size: \(fontSize)px; }';
        document.head.appendChild(style);
        document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(fontSize)px';
        """
        webView.evaluateJavaScript(jsScript, completionHandler: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.body.scrollHeight") { [weak self] result, error in
                if let height = result as? CGFloat {
                    DispatchQueue.main.async {
                        self?.parent.height = height
                    }
                }
            }
        }
    }
}
