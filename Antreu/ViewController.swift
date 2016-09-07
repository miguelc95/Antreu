//
//  ViewController.swift
//  Antreu
//
//  Created by Miguel Bazán on 9/6/16.
//  Copyright © 2016 Miguel Bazán. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,GIDSignInUIDelegate {
    
    //Boton para hacer sign in (gráfico)
    var buttonGoogle: GIDSignInButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Crear el botton (x,y,widht,lenght)
        
        buttonGoogle = GIDSignInButton(frame: CGRectMake(0,0,100,45))
        
        buttonGoogle.center = view.center       // poner el centro del boton en el centro del view
        
        self.view.addSubview(buttonGoogle)
        // auto sign in the user
        // GIDSignIn.sharedInstance().signInSilently()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func post(){
        
    }
    
    


}

