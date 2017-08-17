//
//  sign_up_view.swift
//  Lunch app
//
//  Created by Manan Chugh on 8/12/17.
//  Copyright © 2017 Manan Chugh. All rights reserved.
//

import UIKit

class sign_up_view: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var c_password: UITextField!
    
  
    @IBOutlet weak var debug_check_field: UILabel!
    
    @IBAction func sign_up_pressed(_ sender: Any) {
        signup_post(name:self.name.text!, email: self.email.text!,password: self.password.text!)
        
    }
    
    func signup_post(name:String, email: String, password: String) {
        do {
            let signup_details=[
                "name" : name,
                "email" : email,
                "password" : password ]
            let jsonData = try JSONSerialization.data(withJSONObject: signup_details, options: .prettyPrinted)
            
            let url = NSURL(string: "http://localhost:3000/signup")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]
                    print("Result -> \(result)")
                    
                } catch {
                    print("Error -> \(error)")
                }
            }
            
            task.resume()
        } catch {
            print(error)
        }
        
    }
    

    
    func condition_check() -> Bool {
        if name.text!.isEmpty {
            debug_check_field.text = "Name field Empty."
            return false
        } else if email.text!.isEmpty {
            debug_check_field.text = "Email field Empty."
            return false
        }else if password.text!.isEmpty {
            debug_check_field.text = "Password field Empty."
            return false
        }else if password.text! != c_password.text! {
            debug_check_field.text = "Passwords don't match"
            return false
        }
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "sign_up_segue" {
            let segueShouldOccur = condition_check()
            if !segueShouldOccur {
                return false
            }
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
