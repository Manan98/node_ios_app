//
//  ViewController.swift
//  Lunch app
//
//  Created by Manan Chugh on 7/18/17.
//  Copyright © 2017 Manan Chugh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var username_text: UITextField!
    
    @IBOutlet weak var password_text: UITextField!
    
    @IBAction func login_button_pressed(_ sender: UIButton) {
        login_post(email: self.username_text.text!,password: self.password_text.text!)
    }
    
    func login_post(email: String, password: String) {
            do {
                let login_details=[
                    "email" : email,
                    "password" : password ]
                let jsonData = try JSONSerialization.data(withJSONObject: login_details, options: .prettyPrinted)
                
                let url = NSURL(string: "http://localhost:3000/login")!
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
    

}

