//
//  DetailsViewController.swift
//  Antreu
//
//  Created by Miguel Cuellar on 9/21/16.
//  Copyright © 2016 Miguel Bazán. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var NombreAntro: UILabel!
    var currentPost = Posts()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NombreAntro.text = currentPost.Nombre
        
    }
    

}
