//
//  timeLineTableViewController.swift
//  Chirper
//
//  Created by Mihir Kelkar on 8/2/14.
//  Copyright (c) 2014 Mihir Kelkar. All rights reserved.
//

import UIKit

class timeLineTableViewController: UITableViewController {
    
    
    var timelinedata:NSMutableArray = []
    
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.loadData()
        //********* TUTORIAL PART 7 *******
        //Initially check if a user already exists
        if (!PFUser.currentUser()){
            //if there is no user, then raise an alert for login
            var loginalert: UIAlertController = UIAlertController(title: "Login / Signup ", message: "Please Sign up or Login", preferredStyle: UIAlertControllerStyle.Alert)
            //Add fields to loginAlert
            loginalert.addTextFieldWithConfigurationHandler({
                textfield in textfield.placeholder = "Username"
                })
            loginalert.addTextFieldWithConfigurationHandler({
                textfield in textfield.placeholder = "Password"
                textfield.secureTextEntry = true
                })
            loginalert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                let textfields: NSArray = loginalert.textFields as NSArray
                let usernametextfield:UITextField = textfields.objectAtIndex(0) as UITextField
                let passwordtextfield:UITextField = textfields.objectAtIndex(1) as UITextField
                PFUser.logInWithUsernameInBackground(usernametextfield.text, password: passwordtextfield.text){
                //Lets write a completion handler here to handle wrong login info
                    (user: PFUser! , error: NSError!) -> Void in
                    if (user){
                        println("Login successful")
                    }
                    else{
                    "Login Failed"
                    }
                }
                }))
            
            //Now lets do the same action handler for a sign up
            
            
            loginalert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                let textfields: NSArray = loginalert.textFields as NSArray
                let usernametextfield:UITextField = textfields.objectAtIndex(0) as UITextField
                let passwordtextfield:UITextField = textfields.objectAtIndex(1) as UITextField
                var chirper:PFUser = PFUser()
                chirper.username = usernametextfield.text
                chirper.password = passwordtextfield.text
                
                chirper.signUpInBackgroundWithBlock{
                    (success:Bool!, error:NSError!) -> Void in
                    if (!error){
                        println("Success Registration")
                    }
                    else{
                        let errorstring = error.userInfo["error"] as String
                    }
                }
                }))
            //now present our alert view controller. 
            self.presentViewController(loginalert, animated: true, completion: nil)
            //Tutorial Part 7 ends here Look ahead for table view controller
        }
        
    }

    override func viewDidLoad() {
        self.loadData()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    
    // *************   TUTORIAL PART 8 ****************
    //Displaying all the chirps in our time line. This is basically done with functions from Table View. 
    //create a function called load data which loads chirps from our database.
    //define a list called timelinedata as a class variable thingy
    //We need to load new data everytime, so inside the loaddata function, we will clear the array timelinedata everytime
    //In the loaddata function, we will query our parse database and retrieve all chirp objects.
    //We get all chirps from the timeline using findObjects in Backgroud with block . We add an error handler.
    //We make sure that the newest one remains on top by reversing the just retrieved array
    //Make sure you have outlets for all elements fo the cell view in the cell view class. If not do so.
    //Now lets make a table view cell from the objects we just gathered. 
    //Go to the table view function that retruns a table view.
    //In that function decalre a table view cell called cell. (This may be already done for you)
    //As soon as you uncomment htat function, it will throw an error.
    //So make the tableView option in the decalration as a force wrap using ! and cast the whole function as your cell custom class. 
    //That should make the error go away. 
    //Now you need to fit data from a chirp object into the cell
    
    //Now retrieve data from the chirp object we retrieved from the timelinedata array
    //The way that goes is we use the object at key to get the attribute from the chirp object, cast it as string and add it to the outlet of the cell.
    //set the table view which returns int to the number of objects in timelinedata array
    //Now call self.loaddata method from the viewdidappear function
    func loadData(){
        self.timelinedata = []
        var getTimeLinedata: PFQuery = PFQuery(className: "chirp")
        getTimeLinedata.findObjectsInBackgroundWithBlock{
            (objects: AnyObject[]!, error: NSError!) -> Void in
            if(!error){
                for object:PFObject! in objects{
                    self.timelinedata.addObject(object)
                }
                let array:NSArray = self.timelinedata.reverseObjectEnumerator().allObjects
                self.timelinedata = array as NSMutableArray
                print(self.timelinedata)
            }
        }
        println("This function is being called")
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        println(self.timelinedata.count)
        println("Tha above was from table view int return ")
        println(timelinedata)
        return timelinedata.count
    }

    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        let cell:cheeperTableViewCell = tableView!.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as cheeperTableViewCell
        var chirp:PFObject = timelinedata.objectAtIndex(indexPath!.row) as PFObject
        // Configure the cell...
        cell.chprView.text = chirp.objectForKey("content") as String
        cell.usernameLabel.text = chirp.objectForKey("chirper") as String
        //cell.usernameLabel.text = chirp.d
        println("Table view cell being called")
        return cell
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
