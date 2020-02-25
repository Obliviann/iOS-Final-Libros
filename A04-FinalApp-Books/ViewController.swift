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
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!

    var usr: User?
    
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
        /*self.usr = DataHolder.sharedInstance.firUser                       //TODO: not working
        if let user = usr {                                   //vs if Auth.auth().currentUser != nil
            if usr.isEmailVerified {
            print(user.email ," is already signed in")
                self.performSegue(withIdentifier: "loginSuccess", sender: self)
            }
        }*/
        // TODO: mostrar los datos están almacenados en Core Data
        if CDPersistenceService.fetchFromCoreData(){
            self.performSegue(withIdentifier: "loginSuccess", sender: self)
            //TODO: why wans't segue working when this meth was in viewDidLoad?
        }
    }

    @IBAction func login(_ sender: Any){
        Auth.auth().signIn(withEmail: email.text!, password: pass.text!) { (authDataResult, error) in
            if error == nil {
                self.usr = DataHolder.sharedInstance.firUser //TODO: por estar dentro de un {} más necesita .self?
                if self.usr != nil {
                    print("User ",self.usr?.email," signed in")
                    self.performSegue(withIdentifier: "loginSuccess", sender: self)
                    //CORE DATA    TODO: when I eliminate mandatory sign in after sign up, this should be on sign up
                    CDPersistenceService.saveOnCoreData(email: (self.usr?.email)!)
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

