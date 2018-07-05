//
//  GoogleSignIn.swift
//  GoogleToolboxForMac
//
//  Created by Nitin Bhatia on 05/07/18.
//

import Foundation
import GoogleSignIn

protocol gLoginDelegate {
  func  gLoginDone(parameters:[String:String])
}

class GoogleLogin:NSObject,GIDSignInUIDelegate, GIDSignInDelegate{
    
    var vc : UIViewController!
    var delegate : gLoginDelegate!
    
    init(vc : UIViewController,delegate:gLoginDelegate){
        self.vc = vc
        self.delegate = delegate
    }
    
    
    //MARK:Google SignIn Delegate
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        vc.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        vc.dismiss(animated: true, completion: nil)
    }
    //when the signin compelets
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        //if any error stop and print the error
        if error != nil{
            print(error ?? "google error")
            return
        }
        
        //if success display the email on label
        //labelUserEmail.text = user.profile.email
        //let picture = user.profile.i
        
        let email = user.profile.email
        let userName = user.userID
        let fName = user.profile.name
        let url = user.profile.imageURL(withDimension: UInt(200))
        
        var parameters : [String:String] = [:]
        parameters["username"] = userName
        parameters["password"] = ""
        parameters["login_via"] = "google"
        parameters["fname"] = fName
        parameters["lname"] = ""
        parameters["phone"] = ""
        parameters["email"] = email
        parameters["image"] = "\(url!)"
        parameters["isFound"] = "false"
        
        delegate.gLoginDone(parameters: parameters)
        
    }

}
