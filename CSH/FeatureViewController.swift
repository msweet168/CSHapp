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
    @IBOutlet var back:UIButton!
    @IBOutlet var refresh:UIButton!
    @IBOutlet var forward:UIButton!
    @IBOutlet var homeAdd:UIButton!
    
    
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
        
        if self.title == "Custom" {
            back.isHidden = true
            forward.isHidden = true
            refresh.isHidden = true
            homeAdd.alpha = 1
            
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
    
    @IBAction func addLink(sender:AnyObject) {
        let currentURL = self.webView.request?.url?.absoluteString
        var theNames = UserDefaults.standard.array(forKey: "nameArray")!
        var theLinks = UserDefaults.standard.array(forKey: "linkArray")!
        
        let alert = UIAlertController(title: "Name", message: "What would you like to name your custom link?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            theNames.insert(textField?.text ?? "Custom", at: theNames.count-1)
            theLinks.insert(currentURL ?? "https://members.csh.rit.edu", at: theLinks.count-1)
            
            UserDefaults.standard.set(theNames, forKey: "nameArray")
            UserDefaults.standard.set(theLinks, forKey: "linkArray")
            print("Link added: \(currentURL!)")
            _ = self.navigationController?.popToRootViewController(animated: true)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
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
