//
//  SearchViewController.swift
//  DaitanUniversity_iOS
//
//  Created by Otávio Netto Zani on 03/05/16.
//  Copyright © 2016 Otávio Netto Zani. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, ModelDelegate {

	
	//MARK:- Storyboard Properties
	@IBOutlet weak var textInputView: UITextField!
	@IBOutlet weak var okButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad();
		
		self.textInputView.delegate = self;
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		self.okButton.enabled = self.textInputView.text != "";
		
		Model.sharedInstance().delegate = self;
	}

	
	//MARK:- textFieldDelegate
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder();
		
		self.okButton.enabled = textField.text != "";
		
		return true;
	}
	
	//MARK:- Button Actions
	@IBAction func okPressed(sender: UIButton) {
		Model.sharedInstance().findUser(self.textInputView.text!);
	}
	
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		
		if let vc = segue.destinationViewController as? UsersViewController {
			vc.titleBar.title = self.textInputView.text!;
		}
		
    }
	
	//MARK:- ModelDelegate
	func foundUsers() {
		//all UI operations must be done in the main thread
		NSOperationQueue.mainQueue().addOperationWithBlock(){
			self.performSegueWithIdentifier("foundSegue", sender: self);
		}
	}

}
