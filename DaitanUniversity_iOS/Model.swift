//
//  Model.swift
//  DaitanUniversity_iOS
//
//  Created by Otávio Netto Zani on 04/05/16.
//  Copyright © 2016 Otávio Netto Zani. All rights reserved.
//

import UIKit

typealias User = (login:String, repos_url:String)

@objc protocol ModelDelegate {
	optional func foundUsers()
}

class Model: NSObject {

	//MARK:- Singleton Calls
	static private var _shared:Model? = nil;
	
	static func sharedInstance()->Model{
		if Model._shared == nil {
			Model._shared = Model();
		}
		return Model._shared!;
	}
	
	//MARK:- delegate
	var delegate:ModelDelegate? = nil;
	
	//MARK:- important URLs
	private let base = "https://api.github.com"
	private let search = "/search/users"
	
	
	//MARK:- data to use on the app
	var foundUsers:[User] = []
	
	//MARK:- functions
	
	//Call used on the SearchViewController. It will make a REST call to find users on the github api
	func findUser(name:String){
		
		//create a url
		let url = NSURL(string: base+search+"?q="+name);
		
		//create the request
		let request = NSMutableURLRequest(URL: url!);
		
		//get the request thread
		let session = NSURLSession.sharedSession();
		
		//create a task with the thread and configure the callback
		let task = session.dataTaskWithRequest(request){
			data, response, error in
			
			do{
				let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary;
				
				let users = json["items"] as! NSArray;
				
				users.forEach(){user in
					let login = user["login"] as! String;
					let repos_url = user["repos_url"] as! String;
					self.foundUsers.append((login:login, repos_url:repos_url));
				}
				
			}catch{
				
			}
			
			//reports to our delegate the callback that some users were found
			self.delegate?.foundUsers?();
			
		};
		
		//start the task
		task.resume();
	}
	
	
}
