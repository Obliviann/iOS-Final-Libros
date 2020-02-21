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

    var usr: User?   //*
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // TODO: comprobar que los datos están almacenados en Core Data. call
        if CDPersistenceService.fetchFromCoreData(){
            print("work!!")
            self.performSegue(withIdentifier: "loginSuccess", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //remember user
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //TODO: do not sign in automatically after sign up.
        //TODO: it's called twice before creating usr ???. Why doesn't this if work   ????
        self.usr = DataHolder.sharedInstance.firUser                       //TODO: FIX, not working. Always going to profile (but not creating collection)
        if let user = usr {                                    //vs if Auth.auth().currentUser != nil
            //if usr.isEmailVerified {
            print(user.email ," is already signed in")
                self.performSegue(withIdentifier: "loginSuccess", sender: self)
            //TODO: self.login((Any).self) //-> throws "the pass is invalid of usr does not have a pass" err
            //}
        }
    }

    @IBAction func login(_ sender: Any){
        Auth.auth().signIn(withEmail: email.text!, password: pass.text!) { (authDataResult, error) in
            if error == nil {
                self.usr = DataHolder.sharedInstance.firUser            //TODO: why does it need .self? (por estar dentro de un {} más ?)
                //print("why is usr nil?")                              //*unless I call it inside here, urs is nil
                if self.usr != nil {
                    print("User ",self.usr?.email," signed in")
                    self.performSegue(withIdentifier: "loginSuccess", sender: self)
                    DataHolder.sharedInstance.saveDataOnCoreData(email: (self.usr?.email)!)
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

