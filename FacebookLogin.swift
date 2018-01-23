//
//  FacebookLogin.swift
//  Aliyah Media
//
//  Created by nitin bhatia on 1/23/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import FacebookLogin

class FacebookLogin{
    
    init(vc: UIViewController,completion:@escaping (_ response : [String : AnyObject],_ error : Error?) -> Void){
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile, .email ], viewController: vc) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                let _ = accessToken.authenticationToken
                
                if(FBSDKAccessToken.current() != nil) {
                    
                    let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name,email, picture.type(large)"])
                    
                    graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                        
                        if ((error) != nil)
                        {
                            //                            print("Error: \(error)")
                            completion([:],error)
                            
                        }
                        else
                        {
                            let data:[String:AnyObject] = result as! [String : AnyObject]
                            print(data)
                            self.doFacebookLogin(data: data, completion: {(response,error) in
                                completion(response, error)
                            })
                        }
                    })
                }
            }
        }
    }
    
    
    func doFacebookLogin(data : [String:AnyObject],completion:@escaping (_ response : [String : AnyObject],_ error : Error?) -> Void){
        let apiHandler = ApiHandler()
        let picture = data["picture"] as! [String:AnyObject]
        let tempData = picture["data"] as! [String:Any]
        let url = tempData["url"] as! String
        print(url)
        let email = data["email"] as! String
        print(email)
        let userName = data["id"] as! String + "@facebook.com"
        print(userName)
        let fName = data["first_name"] as! String
        print(fName)
        
        var parameters : [String:String] = [:]
        parameters["username"] = userName
        parameters["password"] = ""
        parameters["login_via"] = "social"
        parameters["fname"] = fName
        parameters["lname"] = ""
        parameters["phone"] = ""
        parameters["email"] = email
        parameters["image"] = url
        
        apiHandler.sendPostRequest(url: "http://192.168.16.4/aliyah-media/index.php?option=com_restapi&task=login&token=livbhhs3GrIpk2yRdEGVkkQT3q1PaUXCFySZeqSaPcnYje4vnjj5", parameters: parameters, completionHandler: {(response,error)in
            if(error != nil){
                completion([:],error)
                return
            }
            completion(response,error)
        })
        
    }

}




