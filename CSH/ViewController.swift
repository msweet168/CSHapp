//
//  ViewController.swift
//  CSH
//
//  Created by Mitchell Sweet on 11/21/16.
//  Copyright © 2016 Mitchell Sweet. All rights reserved.
//

import UIKit

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a\nEEEE, MMM d"
        return formatter.string(from: self)
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var timeAndDateLabel:UILabel!
    @IBOutlet var safariSwitch:UISwitch!
    
    
    var names = ["Discourse", "Webnews", "Profiles", "Calendar", "WebDrink", "WebMail", "Map", "Wiki", "Gallery", "Segfault", "Conditional", "Packet"]
    var links = ["https://discourse.csh.rit.edu", "https://webnews.csh.rit.edu", "https://profiles.csh.rit.edu", "https://calendar.csh.rit.edu", "https://webdrink.csh.rit.edu", "https://rainloop.csh.rit.edu", "https://map.csh.rit.edu", "https://wiki.csh.rit.edu", "https://gallery.csh.rit.edu", "https://segfault.csh.rit.edu", "https://conditional.csh.rit.edu", "https://packet.csh.rit.edu"]
    
    var transferTitle = ""
    var transferLink = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setClock()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setClock), userInfo: nil, repeats: true)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = UIColor.white
        tableView.rowHeight = 80
        
        if UserDefaults.standard.bool(forKey: "safari") {
            safariSwitch.isOn = true
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setClock() {
        timeAndDateLabel.text = Date().toString()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                               reuseIdentifier: "cell")
        cell.textLabel?.text = self.names[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 25)
        let theString = self.links[indexPath.row]
        cell.detailTextLabel?.text = (theString as NSString).substring(from: 8)
        cell.detailTextLabel?.font = UIFont(name: "AvenirNext-Bold", size: 12)
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        transferTitle = names[indexPath.row]
        transferLink = links[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        if UserDefaults.standard.bool(forKey: "safari") {
            let theURL = URL(string: transferLink)
            UIApplication.shared.open(theURL!, options: [:], completionHandler: nil)
        }
        else {
            self.performSegue(withIdentifier: "toWeb", sender: self)
        }
        
    }
    
    
    @IBAction func safariToggled(sender:UISwitch) {
        
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: "safari")
        }
        else {
            UserDefaults.standard.set(false, forKey: "safari")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destinationVC = segue.destination as! FeatureViewController
            destinationVC.service = transferTitle
            destinationVC.urlString = transferLink
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

