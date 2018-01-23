//Mark:- Twitter login
    @IBAction func btnTwitter(_ sender: Any) {
        let _ = TwitterLogin(vc: self,completion: {(response,error) in
            
            if((error) != nil){
                self.showAlert(str: (error?.localizedDescription)!)
                return
            }
            let temp = response["success"] as! Bool
            if(temp){
                self.redirectToHome(response: response["data"] as! [String:AnyObject])
            }
        })
    }
    
    //Mark:- Facebook Login
    @IBAction func btnFacebook(_ sender: Any) {
      let _ =  FacebookLogin(vc: self,completion:{(response,error) in
        
            if((error) != nil){
                self.showAlert(str: (error?.localizedDescription)!)
                return
            }
            print(response)
        })
    }
