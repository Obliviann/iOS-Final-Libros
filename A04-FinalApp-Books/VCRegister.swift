//
//  VCRegister.swift
//  A04-FinalApp-Books
//
//  Created by Olivia Sartorius Freschet on 12/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class VCRegister: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passConfirm: UITextField!
    
    var usr:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtn(_ sender: UIButton){
        //NEVER GO BACK TO A VIEW CONTROLLER WITH A TRIG SEG
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func createAccountBtn(_ sender: UIButton) {
        if (password.text != passConfirm.text) {
            let alertController = UIAlertController(title: "Password does not match", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authDataResult, error) in
                if error == nil {
                    self.usr = DataHolder.sharedInstance.firUser
                    if self.usr != nil {
                        print("USER ",self.usr?.email," was created")  //TODO:** why do I need to force-unwrap the value if it's inside that conditional???
                        
            //FIRESTORE-add (data to) new document with a generated ID, in new collection
                                                                            //TODO: does not code until usr signs in
                        let database = DataHolder.sharedInstance.db
                        var reference = DataHolder.sharedInstance.docRef
                        var dataToSave: [String : Any] = ["email":self.usr?.email]
                        reference = database?.collection("users").document((self.usr?.uid)!)
                        reference?.setData(dataToSave) { (err) in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                print("Document added with ID: ",reference?.documentID) //TODO: ? or !
                                print("User id: \(self.usr?.uid)")
                            }
                        }
                    }
                    //we logout to avoid automatic sign in
                    do {
                        if self.usr != nil {
                            try Auth.auth().signOut()
                            print("User ",self.usr?.email,"signin eliminated")      //**
                        }
                        print("user is ",self.usr?.email)                          //TODO: why is user not nil?????
                    }
                    catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                    //alerts
                    let alertCont = UIAlertController(title: "You have created an account!", message: "You must sign in to habilitate your new account", preferredStyle: .alert)//vs .actionSheet (greyish)
                    let alertAct = UIAlertAction(title: "Neat, take me there pls", style: .cancel, handler: {action in self.loginBtn(sender)})
                    alertCont.addAction(alertAct)
                    self.present(alertCont, animated: true)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
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
