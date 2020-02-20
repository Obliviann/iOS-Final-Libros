//
//  VCProfile.swift
//  A04-FinalApp-Books
//
//  Created by Olivia Sartorius Freschet on 13/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class VCProfile: UIViewController {

    var usr:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutAction(_ sender: UIButton) {
        do {
            usr = DataHolder.sharedInstance.firUser
            if usr != nil {
                print("User ",usr?.email," signing out!")    //TODO:why do I need to force-unwrap the value?
                try Auth.auth().signOut()
            }
            print("user is ",self.usr?.email) //TODO: why is user not nil?????
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        //set the VC to it's root
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
        //self.present(vc!, animated: true, completion: nil)
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
