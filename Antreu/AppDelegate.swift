//
//  AppDelegate.swift
//  Antreu
//
//  Created by Miguel Bazán on 9/6/16.
//  Copyright © 2016 Miguel Bazán. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }


    var window: UIWindow?
    
    
    

    func application(_ application: UIApplication,open url: URL, options:
        [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url,sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func application(_ application: UIApplication,open url: URL, sourceApplication: String?,
        annotation: Any) -> Bool {
        
        var options: [String: AnyObject] = [UIApplicationOpenURLOptionsKey.sourceApplication.rawValue:sourceApplication! as AnyObject,UIApplicationOpenURLOptionsKey.annotation.rawValue: annotation as AnyObject]
        
        return GIDSignIn.sharedInstance().handle(url,sourceApplication: sourceApplication,annotation: annotation)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,withError error: NSError?)
    {
        if let error = error
        {
            print(error.localizedDescription)
            return
        }
        
            let authentication = user.authentication
            let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,accessToken: (authentication?.accessToken)!)
            // ...
            
            FIRAuth.auth()?.signIn(with: credential)
            {
                (user, error) in
            }
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                if let user = FIRAuth.auth()?.currentUser {
                    let name = user.displayName
                    let email = user.email
                    let photoUrl = user.photoURL
                    let uid = user.uid;  // The user's ID, unique to the Firebase project.
                    // Do NOT use this value to authenticate with
                    // your backend server, if you have one. Use
                    // getTokenWithCompletion:completion: instead.
                    print("\(name) \n \(email)")
                    let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "Navigation") as UIViewController
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = initialViewControlleripad
                    self.window?.makeKeyAndVisible()

                } else {
                    // No user is signed in.
                }
            } else {
                // No user is signed in.
            }
        }
    
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,withError error: NSError!)
    {
        // Perform any operations when the user disconnects from app here.
        // ...
        try! FIRAuth.auth()!.signOut()
    }
    

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

