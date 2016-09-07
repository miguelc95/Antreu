//
//  TableViewController.swift
//  Antreu
//
//  Created by Miguel Cuellar on 9/6/16.
//  Copyright © 2016 Miguel Bazán. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct postStruct{
    let title : String!
    let message : String!
}
class TableViewController: UITableViewController {
    
    var posts = [postStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataBaseRef = FIRDatabase.database().reference()
        dataBaseRef.child("Posts").queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {
            snapshot in
            let title = snapshot.value!["title"] as! String
            let message = snapshot.value!["message"] as! String
            self.posts.insert(postStruct(title: title, message: message), atIndex: 0)
            self.tableView.reloadData()
            
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func post(){
        let title = "Title"
        let message = "Message"
        
        let post : [String : AnyObject] =  ["title" : title,
                                            "message" : message]
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Posts").childByAutoId().setValue(post)
        
        }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = posts[indexPath.row].title
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = posts[indexPath.row].message
        return cell!
    }

}
