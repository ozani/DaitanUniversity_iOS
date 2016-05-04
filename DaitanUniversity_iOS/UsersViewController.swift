//
//  UsersViewController.swift
//  DaitanUniversity_iOS
//
//  Created by Otávio Netto Zani on 03/05/16.
//  Copyright © 2016 Otávio Netto Zani. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, ModelDelegate, UITableViewDelegate, UITableViewDataSource {

	
	//MARK:- storyboard variables
	@IBOutlet weak var titleBar: UINavigationItem!
	@IBOutlet weak var tableView: UITableView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.delegate = self;
		self.tableView.dataSource = self;
    }

	override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
		
		Model.sharedInstance().delegate = self;
		
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	//MARK:- button Actions
	@IBAction func backPressed(sender: UIBarButtonItem) {
		Model.sharedInstance().foundUsers = [];
		self.navigationController?.popViewControllerAnimated(true);
	}
	
	//MARK:- TableViewDataSource
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Model.sharedInstance().foundUsers.count;
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1;
	}
	
	//configure the cells
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		//get a reusable cell
		let cell = tableView.dequeueReusableCellWithIdentifier("labelCell", forIndexPath: indexPath) as! LabelTableViewCell;
		
		let row = indexPath.row;
		
		cell.label.text = Model.sharedInstance().foundUsers[row].login;
		
		return cell;
	}
	
	//MARK:- tableViewDelegate
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		print(Model.sharedInstance().foundUsers[indexPath.row]);
	}
	
}
