//
//  LoginWebViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit
import WebKit

class LoginWebViewController: UIViewController {
    
    private var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = webView
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        if let request = NetworkingService().getAuthorizeRequest(){
            webView.load(request)
        }
    }
}

extension LoginWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce ([String:String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
                
        }
        
        let token = params["access_token"]
        let userID = params["user_id"]
        Session.shared.userID = Int(userID ?? "")
        Session.shared.token = token!

        if token != nil {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }
        
        decisionHandler(.cancel)
    }
}


