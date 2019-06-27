//
//  ViewController.swift
//  Habasa
//
//  Created by Malik on 11/06/2019.
//  Copyright © 2019 Abdulmalik Muhammad. All rights reserved.
//

import UIKit
import WebKit

class Browser: UIViewController, UITextFieldDelegate, WKNavigationDelegate{
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var loadingBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInput.delegate = self
        myWebView.navigationDelegate = self
        updateUI()
    }
    
    func updateUI() {
        myWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        loadingBar.isHidden = true
        backButton.tintColor = .gray
        forwardButton.tintColor = .gray
        refreshButton.tintColor = .gray
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        refreshButton.isEnabled = false
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        //where to start loading
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        loadingBar.isHidden = false
        userInput.text = webView.url?.absoluteString
       
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
        browserControls(yourWebView: webView, back: backButton, forward: forwardButton)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        refreshButton.tintColor = UIColor.systemBlue
        refreshButton.isEnabled = true
        loadingBar.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //Habasa cannot open page because the server cannot be found.
        print(#function)
        showErorr(err: error)
        loadingBar.progress = Float(myWebView.estimatedProgress)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userInput {
            loadWebsiteUserIput()
            myWebView.allowsBackForwardNavigationGestures = true
           // performSegue(withIdentifier: segueToDownload, sender: self)
            textField.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    
    //check if download file contains mp4 or mp3
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        let path = navigationAction.request.url?.absoluteString
        let filename = navigationAction.request.url?.lastPathComponent ?? "Videoname"
        if let path = path {
            if path.hasSuffix("mp4"){
                // This is video link, don't let iOS open video
                decisionHandler(.cancel)
                promptDownloadOptions(mediaUrl: path, filename: filename)
                 return
            }
        }
        // Any other link should be handled by WKWebView
        decisionHandler(.allow)
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        if myWebView.canGoBack {
            backButton.tintColor = .systemBlue
            myWebView.goBack()
        }
    }
    
    @IBAction func forwardButton(_ sender: UIBarButtonItem) {
        if myWebView.canGoForward {
            forwardButton.tintColor = .systemBlue
            myWebView.goForward()
        }
    }
    
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        myWebView.reload()
        refreshButton.tintColor = .systemBlue
    }
    
    //loading progress for the browser
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            loadingBar.progress = Float(myWebView.estimatedProgress)
        }
    }
    
    
    //Pop up with Download Menu
    public func promptDownloadOptions(mediaUrl: String, filename: String) {
        let alert = UIAlertController(title: nil, message: filename, preferredStyle: .actionSheet)
        let addbt = UIAlertAction(title: "Download", style: .default) { (btn) in
            
            NetworkingWithAlamofire.instance.downloading(mediaUrl: mediaUrl, downloadfileName: filename, downloadProgress: self.loadingBar)
            
        }
        let addCopy = UIAlertAction(title: "Copy Link", style: .default, handler: nil)
        
        let addcancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(addcancel)
        alert.addAction(addbt)
        alert.addAction(addCopy)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
