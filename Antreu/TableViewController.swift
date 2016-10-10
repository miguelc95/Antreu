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

/*struct postStruct{
    let Nombre : String!
    let Lugar : String!
}
 */
class TableViewController: UITableViewController {
    
    var posts = [Posts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // post()
        
        let dataBaseRef = FIRDatabase.database().reference()
        dataBaseRef.child("Antros").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
            let nombre = snapshot.value!["Nombre"] as! String
            let lugar = snapshot.value!["Lugar"] as! String
            let newPost = Posts()
            newPost.Nombre = nombre
            newPost.Lugar = lugar
            self.posts.insert(newPost , at: 0)
            self.tableView.reloadData()
        })
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func post(){  // Función que hace post en la base de datos
        let Nombre = "Sr. Mostacho"
        let Lugar = "Paseo Tec"
        
        let post : [String : AnyObject] =  ["Nombre" : Nombre as AnyObject,
                                            "Lugar" : Lugar as AnyObject]
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Antros").childByAutoId().setValue(post)
        
        
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = posts[(indexPath as NSIndexPath).row].Nombre
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = posts[(indexPath as NSIndexPath).row].Lugar
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as? DetailsViewController
        let selectedPost = posts[(self.tableView.indexPathForSelectedRow! as NSIndexPath).row]
        destination?.currentPost = selectedPost
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \((indexPath as NSIndexPath).row)!")
        self.performSegue(withIdentifier: "Details", sender: self)
    }
    
    

}
