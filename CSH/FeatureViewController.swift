//
//  FeatureViewController.swift
//  CSH
//
//  Created by Mitchell Sweet on 11/21/16.
//  Copyright © 2016 Mitchell Sweet. All rights reserved.
//

import UIKit

class FeatureViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView:UIWebView!
    @IBOutlet var loading:UIActivityIndicatorView!
    
    var service = String()
    var urlString = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loading.layer.cornerRadius = 5
        viewSetup()
    }
    
    
    func viewSetup() {
        
        
        let request = URLRequest(url: URL(string: urlString)!)
        webView.loadRequest(request)
        
        if let bar = navigationController?.navigationBar {
            bar.isHidden = false
            self.title = service
            bar.barTintColor = #colorLiteral(red: 0.8068675399, green: 0.1540440619, blue: 0.5591783524, alpha: 1)
            bar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
            bar.tintColor = UIColor.white
            //bar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir Next Bold", size: 21)!]
        }
        else {
            print("FATAL ERROR: Navigation bar not found")
        }
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loading.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loading.stopAnimating()
    }
    
    @IBAction func back(sender:AnyObject) {
        webView.goBack()
    }
    
    @IBAction func forward(sender:AnyObject) {
        webView.goForward()
    }
    
    @IBAction func refresh(sender:AnyObject) {
        webView.reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
