//
//  ViewController.swift
//  A04-FinalApp-Books
//
//  Created by Olivia Sartorius Freschet on 12/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var loginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*@IBAction func SignUpBtn(_ sender: Any){
        self.performSegue(withIdentifier: "RegisterVC", sender: self)
    }*/
    
    @IBAction func SignInBtn(_ sender: Any){
        Auth.auth().signIn(withEmail: email.text!, password: pass.text!) { (user, error) in
            if error == nil{
                print("User ",user," signed in")
                self.performSegue(withIdentifier: "loginSuccess", sender: self)
            }
            else{
                print("ERROR EN LOGIN: ",error!)
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }

    }

}

