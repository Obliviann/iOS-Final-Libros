//
//  DataHolder.swift
//  A04-FinalApp-Books
//
//  Created by Olivia Sartorius Freschet on 12/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

//2
protocol DHDelegate {
    func DHUserLogin(userr: User)
}

//static class that will maintain data consistency between views
class DataHolder: NSObject {
    
    var delegate: DHDelegate?
    
    static let sharedInstance:DataHolder = DataHolder()
    //listener to handle the AUTH STATE
    //this listener gets called whenever the user's sing-in state changes
    var handle: AuthStateDidChangeListenerHandle?
    var userAuth:User?
    var db: Firestore!
    
    
    func initFirebase(){
        FirebaseApp.configure()
        db = Firestore.firestore()
    }
    
    //NOT ACTUALLY USING THIS since I'm usitn currentUser meth
    func didUserStateChange() {
        //We set a listener on the FIRAuth obj to GET THE CURRENTLY SIGNED-IN USER
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            //REPEATED CODE IN ALL VC
            if let usr = user {
                // User is signed in.
                DataHolder.sharedInstance.userAuth = usr
                self.delegate?.DHUserLogin(userr: usr)
            } else {
                // No user is signed in.
            }
        }
    }
    
    func detachStateListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}
