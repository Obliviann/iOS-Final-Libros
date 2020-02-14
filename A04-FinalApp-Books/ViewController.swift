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
//        if Auth.auth().currentUser != nil {
//            self.performSegue(withIdentifier: "loginSuccess", sender: nil)
//        } SAME AS (better option ahead):

        //TODO: do not sign in automatically after sign up.
        //TODO: it's called twice before creating usr ???. Why doen's this if work   ????
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let usr = user {
                //if usr.isEmailVerified {
                    print(usr.email," is already signed in")
                    self.performSegue(withIdentifier: "loginSuccess", sender: self)
                //TODO: self.login((Any).self) //-> throws "the pass is invalid of usr does not have a pass" err
                //}
            }
        }
        
    }
    
    @IBAction func login(_ sender: Any){
        Auth.auth().signIn(withEmail: email.text!, password: pass.text!) { (authData, error) in
            if (error == nil) {
                //Done with listener in VCRegister
                let user = Auth.auth().currentUser //VS. DataHolder.sharedInstance.handle ???
                if let usr = user {
                    //DataHolder.sharedInstance.firUser = usr
                    print("User ",usr.email," signed in")
                    self.performSegue(withIdentifier: "loginSuccess", sender: self)
                }
            }else{
                print("ERROR EN LOGIN: ",error!)
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

}

