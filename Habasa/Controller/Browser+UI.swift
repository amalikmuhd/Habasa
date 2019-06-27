//
//  Browser+UI.swift
//  Habasa
//
//  Created by Malik on 14/06/2019.
//  Copyright © 2019 Abdulmalik Muhammad. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

extension Browser {
    
   public func loadWebsiteUserIput(){
        let addOnHttps = "https://www."
        let addOnHttp = "http://www."
        let google = "https://www.google.com/search?q="
        
        
        if (userInput.text?.hasPrefix(addOnHttps))!{
            userInput.text?.removeFirst(12)
            let websiteName = URL(string: addOnHttps +  userInput.text!.lowercased())
            loadRequest(websiteName: websiteName!)
        } else if (userInput.text?.hasPrefix(addOnHttp))! {
            userInput.text?.removeFirst(11)
            let websiteName = URL(string: addOnHttp +  userInput.text!.lowercased())
            loadRequest(websiteName: websiteName!)
        }else {
            if (userInput.text?.contains("."))! {
                let websiteName = URL(string: addOnHttp + userInput.text!.lowercased())
                loadRequest(websiteName: websiteName!)
            } else {
                let websiteName = URL(string: google +  userInput.text!.lowercased())
                loadRequest(websiteName: websiteName!)
            }
            
        }
        
    }
    
    //load website
    public func loadRequest(websiteName: URL){
        let myRequest = URLRequest(url: websiteName)
        myWebView.load(myRequest)
    }
    
    //load default website
    public func loadDefaultWebsite(addOn: String){
        let websiteName = URL(string: addOn)
        let myRequest = URLRequest(url: websiteName!)
        myWebView.load(myRequest)
    }
    
    /// Allow Interaction between user and browser
    /// - Parameter yourWebView: Instance of WKWebView
    /// - Parameter back: back button of your browser
    /// - Parameter forward: forward button of your browser
   public func browserControls(yourWebView: WKWebView, back: UIBarButtonItem, forward: UIBarButtonItem) {
        //back button
        if yourWebView.canGoBack {
            back.tintColor = .blue
            back.isEnabled = true
        } else {
            back.tintColor = .gray
        }
        
        //forward button
        if yourWebView.canGoForward {
            forward.tintColor = .blue
            forward.isEnabled = true
        } else {
            forward.tintColor = .gray
        }
    }
    
   public func showErorr(err: Error){
        if let errCode = err as? URLError {
            switch errCode.code {
            case .cannotFindHost:
                showAlert(title: "Website cannot be found", message: "Habasa cannot open this page because the server cannot be found")
            case .notConnectedToInternet:
                showAlert(title: "Mobile Data is Turned Off", message: "Turn on mobile data or use Wi-Fi to access data.")
            case .resourceUnavailable:
                showAlert(title: "Network", message: "Resource Unavailable")
            case .unsupportedURL:
                showAlert(title: "Permission Not Allowed", message: "Habasa does not support such websites")
            default:
                break
            }
        }
    }
    
    func showAlert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let addButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(addButton)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}
