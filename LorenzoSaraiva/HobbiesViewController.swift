//
//  HobbiesViewController.swift
//  LorenzoSaraiva
//
//  Created by Lorenzo Saraiva on 4/15/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

import UIKit

class HobbiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var hobbiesTableView: UITableView!
    var hobbiesArray:[String] = ["Games","Soccer","Programming"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hobbiesTableView.delegate = self
        hobbiesTableView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hobbiesArray.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = hobbiesTableView.dequeueReusableCellWithIdentifier("HobbieCell") as! UITableViewCell
        cell.textLabel?.text = hobbiesArray[indexPath.row]
        return cell
    }

}
