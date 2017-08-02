//
//  forgot_password_view.swift
//  Lunch app
//
//  Created by Manan Chugh on 8/2/17.
//  Copyright © 2017 Manan Chugh. All rights reserved.
//

import UIKit

class forgot_password_view: UIViewController {

    @IBOutlet weak var new_email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func send_pressed(_ sender: UIButton) {
        
        forgot_post(email: self.new_email.text!)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func forgot_post(email: String) {
        do {
            let forgot_details=[
                "email" : email,
                ]
            let jsonData = try JSONSerialization.data(withJSONObject: forgot_details, options: .prettyPrinted)
            
            let url = NSURL(string: "http://localhost:3000/forgot_password")!
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
