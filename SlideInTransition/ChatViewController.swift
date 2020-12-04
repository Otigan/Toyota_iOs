//
//  ChatViewController.swift
//  SlideInTransition
//
//  Created by otigan on 07.11.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit
import WebKit

class ChatViewController: UIViewController {
    
    
    var webView: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.toyota-rest.ru/chat")!
        
        let script = "ins=document.getElementsByTagName('input');" +
        "ins[1].value='blabla@mail.ru';" +
        "ins[2].value='blabla123';" +
        "btn=document.getElementsByTagName('button');" +  "btn[1].click();"
        
        let userScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let pref = WKPreferences()
        pref.javaScriptEnabled = true
        
        let contentController = WKUserContentController()
        contentController.addUserScript(userScript)
        
        let conf = WKWebViewConfiguration()
        conf.userContentController = contentController
        conf.preferences = pref
        
        
        webView = WKWebView(frame: view.bounds, configuration: conf)
        
        view.addSubview(webView)
        
        
        
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        //webview.allowsBackForwardNavigationGestures = true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
