//
//  ViewController.swift
//  A04-FinalApp-Books
//
//  Created by Olivia Sartorius Freschet on 12/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

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
    
    //remember user
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //retrieve the current user logged in with the system:
        //TODO: only do this whe usr has signed in, NOT when it created an account
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "loginSuccess", sender: nil)
        }
    }
    
    @IBAction func signInBtn(_ sender: UIButton){
        Auth.auth().signIn(withEmail: email.text!, password: pass.text!) { (user, error) in
            if error == nil{
                let user = Auth.auth().currentUser //TODO: change for DataHolder.sharedInstance.handle
                if let usr = user {
                    //DataHolder.sharedInstance.userAuth = usr
                    print("User ",usr.email," signed in")
                    self.performSegue(withIdentifier: "loginSuccess", sender: self)
                }
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

