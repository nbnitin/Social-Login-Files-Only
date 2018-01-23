//
//  TwitterLogin.swift
//  Aliyah Media
//
//  Created by nitin bhatia on 1/23/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import Foundation

class TwitterLogin{
    init(vc: UIViewController,completion:@escaping (_ response : [String : AnyObject],_ error : Error?) -> Void){
        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                //Mark:- Getting user details from twitter
//                print(session?.userName)
//                print(session?.userID)
                
                
                self.getUserEmail(session: session!,compleiton: {(response,error) in
                    completion(response,error)
                })
                
            }
        })
                
    }
    
    //Mark:- Get user email and additional details also
    func getUserEmail(session:TWTRSession,compleiton:@escaping (_ response : [String : AnyObject],_ error : Error?) -> Void){
        let client = TWTRAPIClient.withCurrentUser()
        let request = client.urlRequest(withMethod: "GET",
                                        urlString: "https://api.twitter.com/1.1/account/verify_credentials.json?include_email=true",
                                        parameters: ["include_email": "true", "skip_status": "true"],
                                        error: nil)
        client.sendTwitterRequest(request) { response, data, connectionError in
            if (connectionError == nil) {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    print("Json response: ", json)
                    let firstName = json["name"]
                    let _ = json["screen_name"]
                    let email = json["email"]
                    let picture = json["profile_image_url"]
                    let id = json["id"] as! NSNumber
                   
                    var data : [String:String] = [:]
                    data["picture"] = picture as? String
                    data["email"] = email as? String
                    data["id"] = id.stringValue
                    data["first_name"] = firstName as? String
                    
                    self.doTwitterLogin(data: data, completion: { (response,error) in
                        compleiton(response,error)
                    })
                } catch {
                    
                }
                
            }
            else {
                compleiton([:],connectionError)
            }
        }
    }
    
    //Mark:- Below function not giving email addresse of the user, that why I am using above function
    func getUserData(session:TWTRSession){
        let client = TWTRAPIClient()
        client.loadUser(withID: (session.userID)) { (user, error) -> Void in
            // handle the response or error
            
            let tweetUser : TWTRUser = user!
            let url = "https://api.twitter.com/1.1/users/show.json"
            let params = ["screen_name": tweetUser.screenName]
            let req =  client.urlRequest(withMethod: "GET", urlString: url, parameters: params, error: nil)
            client.sendTwitterRequest(req) { (response, data, connectionError) -> Void in
                if let someData = data {
                    do {
                        let results = try JSONSerialization.jsonObject(with: someData, options: .allowFragments) as! [String:AnyObject]
                        print(results)
                        let data : [String:String] = [:]
                        
                        
                    } catch {
                    }
                }
            }
        }
    }
    
    func doTwitterLogin(data : [String:String],completion:@escaping (_ response : [String : AnyObject],_ error : Error?) -> Void){
        let apiHandler = ApiHandler()
        let url = data["picture"] as! String
        
        let email = data["email"] as! String
        print(email)
        let userName = data["id"] as! String + "@twitter.com"
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
