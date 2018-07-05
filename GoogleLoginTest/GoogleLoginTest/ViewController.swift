//
//  ViewController.swift
//  GoogleLoginTest
//
//  Created by Nitin Bhatia on 05/07/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController,gLoginDelegate {
    
    var gLogin : GoogleLogin!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Mark:- Google sign in
        //adding the delegates
        gLogin = GoogleLogin(vc: self,delegate:self)
        GIDSignIn.sharedInstance().uiDelegate = gLogin
        GIDSignIn.sharedInstance().delegate = gLogin
        
        //getting the signin button and adding it to view
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.center = self.view.center
        self.view.addSubview(googleSignInButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark:- Google delegate
    func gLoginDone(parameters: [String : String]) {
        print(parameters)
    }
}

