//
//  createChirpsViewController.swift
//  Chirper
//
//  Created by Mihir Kelkar on 8/2/14.
//  Copyright (c) 2014 Mihir Kelkar. All rights reserved.
//

import UIKit
//  ****** TUTORIAL PART 4 ********
//Copy outlets from the textview, the labels and 
//the done button in the class here.

//For the done button, use a action outlet instead. 
//Also define an init code , decoder function. 
//Copy the same function in the timeLinetableView controller code.
//Now define a new class f/Users/mihirkelkar/code/Chirper/createChirpsViewController.swiftor the table view cell.
//Part 5 in the table view cell class. 

// ********  TUTORIAL PART 6 ********
//Adding the actual logic now. Lets add a little rounded border to our text view first. Lets do this in the view did load function
//  Now lets make the textview get the keyboard if touched inside. In the view did load. 

//Now lets go ahead and code the send chirp function. Done button. 
//Now as you might have noticed, after coding that the PFUSer doesn't exist yet. So we go to the timeline Controller and define a view did appear function
//
class createChirpsViewController: UIViewController {

    @IBOutlet var chirpText: UITextView? = UITextView()
    @IBOutlet var charRemaining: UILabel? = UILabel()
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        chirpText!.layer.borderColor = UIColor.blackColor().CGColor
        chirpText!.layer.borderWidth = 0.5
        chirpText!.layer.cornerRadius = 5
        chirpText!.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        //Creating a Parse class called chirp by object instantiation. Yeah wierd.
        var chirp: PFObject = PFObject(className: "chirp")
        //now we will create class attributes on the fly. 
        chirp["content"] = chirpText!.text
        chirp["chirper"] = PFUser.currentUser()
        chirp.saveInBackground()
        //Now once the chirp is completed, just move on to the home screen
        self.navigationController.popToRootViewControllerAnimated(true)
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
