//
//  ShowWebView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 05/08/24.
//

import SwiftUI
import WebKit

enum FontSize: String, CaseIterable, Identifiable {
    case small = "Small"
    case regular = "Regular"
    case large = "Large"
    case extraLarge = "Extra Large"
    case maximum = "Maximum"
    
    var id: String { self.rawValue }
}

struct ShowWebView: View {
    @State private var webViewHeight: CGFloat = .zero
    @State private var fontSize: FontSize = .regular
    let arrFonts = [
        DropDownModel(dict: ["title": FontSize.small.rawValue, "id": "1"]),
        DropDownModel(dict: ["title": FontSize.regular.rawValue, "id": "3"]),
        DropDownModel(dict: ["title": FontSize.large.rawValue, "id": "6"]),
        DropDownModel(dict: ["title": FontSize.extraLarge.rawValue, "id": "9"]),
        DropDownModel(dict: ["title": FontSize.maximum.rawValue, "id": "12"])
    ]
    @State var isSideMenuOpen: Bool = false
    @State var spotlight: Bool = false

    @State var isOpen: Bool = false
    @State private var selectedFontSize = 0
    @State private var updateDescrfont: CGFloat = 9

    var body: some View {
        VStack{
            CustomNavigationBar(isBack: true, title: "NAVIGATION", isSideMenuOpen: $isSideMenuOpen, spotlight: $spotlight) {
                isOpen = true
            }
         
            VStack {
                ScrollView {
                    DynamicWebView(htmlContent: """
                        <p>The MoU, signed on the sidelines of the event, signifies a mutual commitment to enhancing defence cooperation, technology transfer, and joint production efforts. Minister Bhatt hailed the agreement as a testament to the growing partnership between the two nations.</p>
                        <p>By Vinod Kumar, Dubai.</p>
                        <p>Minister of State for Defence, Ajay Bhatt, is currently on a five-day visit to Riyadh from February 4th to 8th, 2024, for the World Defence Show 2024. The visit has yielded a significant milestone with the signing of a Memorandum of Understanding between Munitions India Limited and a local partner, underscoring the deepening collaboration between India and Saudi Arabia in the field of defence.</p>
                        <p>The MoU, signed on the sidelines of the event, signifies a mutual commitment to enhancing defence cooperation, technology transfer, and joint production efforts. Minister Bhatt hailed the agreement as a testament to the growing partnership between the two nations.</p>
                        <p>During this visit to Riyadh, Minister Bhatt actively engaged in discussions with key Saudi officials, highlighting the importance of bolstering bilateral defense ties. Among those he met was Defense Minister Khalid bin Salman bin Abdulaziz Al-Saud, where they discussed avenues for collaboration aimed at enhancing regional security.</p>
                        <p>Both sides emphasized the significance of joint training exercises and the exchange of expertise in strengthening defense capabilities. Additionally, Minister Bhatt held talks with Assistant Minister of Defence of Saudi Arabia, Dr. Khaled Al-Bayari, focusing on further enhancing the long-standing defense cooperation between the two nations.</p>
                        <p>The discussions centered around exploring various areas of mutual interest, including increasing joint training exercises, technology transfer, and the exchange of expertise. These conversations are crucial in solidifying the foundation for defense cooperation between India and Saudi Arabia.</p>
                        <p>Minister Bhatt also had a productive discussion with Ahmad Al-Ohali, Governor of the General Authority for Military Industries (GAMI), on the sidelines of the World Defence Show in Riyadh. These engagements aim to strengthen the collaborative efforts between India and Saudi Arabia in defense, paving the way for enhanced regional security and cooperation.</p>
                        <p>Minister Bhatt also commended Indian defense companies for their innovative technologies showcased at the event, highlighting the potential for further collaboration. He underscored the alignment between Saudi Arabia’s Vision 2030 and India’s Atma Nirbhar Bharat initiatives, emphasising the shared goal of technological advancement and self-reliance.</p> <p>Minister Bhatt also had a productive discussion with Ahmad Al-Ohali, Governor of the General Authority for Military Industries (GAMI), on the sidelines of the World Defence Show in Riyadh. These engagements aim to strengthen the collaborative efforts between India and Saudi Arabia in defense, paving the way for enhanced regional security and cooperation.</p>
                        <p>Minister Bhatt also commended Indian defense companies for their innovative technologies showcased at the event, highlighting the potential for further collaboration. He underscored the alignment between Saudi Arabia’s Vision 2030 and India’s Atma Nirbhar Bharat initiatives, emphasising the shared goal of technological advancement and self-reliance.</p>
                    
                        <p>The visit marks a significant step forward in the India-Saudi Arabia partnership, laying the groundwork for expanded cooperation in defense. Minister Bhatt expressed confidence in the continued growth of the alliance, foreseeing a safer and more prosperous future for both nations and the broader region.</p>
                    """, fontSize: updateDescrfont, webViewHeight: $webViewHeight)
                    .frame(height: webViewHeight)
                    .background(.red)
                }
            }
        }.fullScreenCover(isPresented: $isOpen) {
            PopUpView(arrList: arrFonts,selectedId: selectedFontSize ) { selectedValue in
                selectedFontSize = Int(selectedValue)
                updateDescrfont = CGFloat(selectedFontSize * 3)
            }
        }
        if isOpen {
            
        }
    }
    
}

struct DynamicWebView: UIViewRepresentable {
    let htmlContent: String
    var fontSize: CGFloat
    @Binding var webViewHeight: CGFloat
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = false // Disable scrolling in the webview to manage dynamic height
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let modifiedHTMLContent = htmlWithCSS(strContent: htmlContent, fontSize: fontSize, backgroundColor: "#FF5733")
        webView.loadHTMLString(modifiedHTMLContent, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: DynamicWebView
        
        init(_ parent: DynamicWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.offsetHeight", completionHandler: { height, error in
                if let height = height as? CGFloat {
                    DispatchQueue.main.async {
                        self.parent.webViewHeight = height
                    }
                }
            })
        }
    }
}

func htmlWithCSS(strContent: String, fontSize: CGFloat, backgroundColor: String) -> String {
    let strCSS: String = """
    <header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>
<html>
<style>
@font-face {
    font-family: 'Open Sans';
    font-weight: normal;
    src: url(ProximaNova-Regular.otf);
}
@font-face {
    font-family: 'Open Sans';
    font-weight: bold;
    src: url(ProximaNova-Semibold.otf);
}
@font-face {
    font-family: 'Open Sans';
    font-weight: 500;
    src: url(ProximaNova-Semibold.otf);
}
@font-face {
    font-family: 'Open Sans';
    font-weight: 900;
    src: url(ProximaNova-Extrabold.otf);
}
body {
    font-family: 'Open Sans';
    font-size: \(fontSize)px;
    background-color: \(backgroundColor);
}
img {
    width: 100%;
}
</style>
<body>\(strContent)</body>
</html>
"""
    return strCSS
}


