//
//  ViewController.swift
//  cryptoBuild
//
//  Created by Administrator on 09/06/2023.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var wkWebView: WKWebView!
//    var webView: WKWebView!
//    var loadCS: Bool = true
//    var withoutBalance: Bool = false
    var urlString: String = ""
    var txtAppend = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        initWebView()
//        checkLoginStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if !loadCS && !withoutBalance{
////            checkLoginStatus()
//            initNavigationRightBar()
//        }else{
//            let rightItem = UIBarButtonItem(title: "刷新", style: .plain, target: self, action: #selector(self.webViewReload))
//            self.navigationItem.rightBarButtonItem = rightItem
//        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        if !loadCS && !withoutBalance{
//            BalanceRefreshUtil().refreshBalance()
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = wkWebView.estimatedProgress == 1
            progressView.setProgress(Float(wkWebView.estimatedProgress), animated: true)
        }
    }
}

extension ViewController {
    func setupView(){
        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
        wkWebView.scrollView.bounces = false
        wkWebView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        wkWebView.configuration.preferences.javaScriptEnabled = true
        wkWebView.configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        wkWebView.allowsBackForwardNavigationGestures = true
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        let request = URLRequest(url: URL(string: "https://stg-t1-m.rpgp.cc?isApp=true")!)
        wkWebView.load(request)

//        do {
//                guard let filePath = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "dist")
//                    else {
//                        // File Error
//                        print ("File reading error")
//                        return
//                }
//
////            wkWebView.loadFileURL(filePath, allowingReadAccessTo: filePath)
//
//            }
//
//
    }
//    func actionReload(firstTime: Bool = false){
//         let urlString = self.urlString.replacingOccurrences(of: "http://", with: "https://")
//        let replaceDomain = urlString.replacingOccurrences(of: "mrcat.com", with: "\(GlobalInfoUtil.domain).com")
//
//        if firstTime {
//            txtAppend = replaceDomain.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? ""
//            let url = URL(string: txtAppend)
//            if loadCS {
//                MixPanelLog().setEvent(["CS_URL":txtAppend, "CS_URL_DNS": UIUtil.urlToIP_gethostbyname(URL(string: self.urlString)!).joined(separator: ",")], EnumUtil.action.customer_service.rawValue)
//                print("stringsting1: \(self.urlString)")
//                print("stringsting2: \(txtAppend)")
//            }
//            webView.load(URLRequest(url: url!))
//            webView.allowsBackForwardNavigationGestures = true
//        }else{
//            webView.reload()
//        }
//    }
//    func webViewReload() {
//        webView.reload()
//    }
    func dismissPage(){
        
//        if csDelegateType == .backRootView {
//            if let composeViewController = self.navigationController?.viewControllers[0] {
//                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//                self.navigationController?.navigationBar.shadowImage = UIImage()
//                self.navigationController?.popToViewController(composeViewController, animated: true)
//            }
//        }else{
            self.navigationController?.popViewController(animated: true)
//        }
    }
//    func webView(_ webView: WKWebView,
//        didReceive challenge: URLAuthenticationChallenge,
//        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void){
//        if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust)
//        {
//            let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//            completionHandler(.useCredential, cred)
//        }
//        else
//        {
//            completionHandler(.performDefaultHandling, nil)
//        }
//    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        if(navigationAction.navigationType == .other) {
//            if let redirectedUrl = navigationAction.request.url {
//                if txtAppend != redirectedUrl.absoluteString {
//                    self.webView?.evaluateJavaScript("document.querySelector('body').innerHTML") { (result, error) in
//                        if error != nil {
//                            MixPanelLog().setEvent(["CS_REDIRECT_URL":redirectedUrl.absoluteString, "CS_REDIRECT_URL_DNS":UIUtil.urlToIP_gethostbyname(redirectedUrl).joined(separator: ",")], EnumUtil.action.customer_service.rawValue)
//                        }
//                    }
//                }
//            }
//        }

//        self.log(navigationAction.request.url?.absoluteString)
//        self.log(navigationAction.navigationType.hashValue)
//        self.log(navigationAction.request.allHTTPHeaderFields)
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    }
}
extension ViewController: WKUIDelegate, WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let reqUrl = webView.url?.absoluteString
//        print("loadedURL:\(reqUrl)")
//        if (reqUrl?.hasPrefix("alipays://"))! || (reqUrl?.hasPrefix("alipay://"))! {
//            let bSucc = UIApplication.shared.openURL(webView.url!)
//            if !bSucc {
//                let util = NormalAlertLauncher(title: "提示", message: "未检测到支付宝客户端，请安装后重试。", defaultColor: true)
//                util.addButton(title: MessageUtil.cancel) {
//                    util.popOut()
//                }
//                util.addButton(title: "立即安装") {
//                    let urlStr = "https://itunes.apple.com/cn/app/zhi-fu-bao-qian-bao-yu-e-bao/id333206289?mt=8"
//                    let downloadURL = URL(string: urlStr)
//                    UIApplication.shared.openURL(downloadURL!)
//                }
//                util.presentIn(self)
//            }
//        }
        
        
//        print("convertTOIp: \(urlToIP(webView.url!))")
//        customLoading.isHidden = false
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        customLoading.isHidden = true
//        alert.show(false, withMessage: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        let script = "localStorage.getItem(\"token\")"
//            wkWebView.evaluateJavaScript(script) { (token, error) in
//                if let error = error {
//                    print ("localStorage.getitem('token') failed due to \(error)")
//                    assertionFailure()
//                }
//                print("token = \(token)")
//            }
//        print("yoyoherere: \(webView.url!)")
//         customLoading.isHidden = true
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
//        let util = NormalAlertLauncher(title: "", message: message, defaultColor: true)
//        util.addButton(title: MessageUtil.cancel) {
//            completionHandler(false)
//        }
//        util.addButton(title: "确定") {
//            completionHandler(true)
//        }
//        util.presentIn(self)
    }
    
//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        if navigationAction.targetFrame == nil {
//            webView.load(navigationAction.request)
//        }
//        return nil
//    }
//    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
//        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
//            completionHandler()
//        }))
//
//        present(alertController, animated: true, completion: nil)
//    }
    func webView(_ webView: WKWebView,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    
    {
        if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust)
            {
                let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                completionHandler(.useCredential, cred)
            }
            else
            {
                completionHandler(.performDefaultHandling, nil)
            }
    }
}
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
extension ViewController {
    func initWebView() {
//        let height = (self.navigationController?.navigationBar.frame.height)! + UIUtil.statusBarFrame.height
//        webView = WKWebView(frame: CGRect(x: 0, y: height, width: UIUtil.FullSize.width, height: UIUtil.FullSize.height - height))
   
//        view.addSubview(webView)
//        view.bringSubviewToFront(progressView)
//        customLoading = loading.getLoadView()
//        self.view.addSubview(customLoading)
//        self.keyboardShowHeight = 0
//        customLoading.isHidden = false
    }
}




