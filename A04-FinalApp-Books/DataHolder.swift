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
    func DHUserLogin(usr: User)
}

//static class that will maintain data consistency between views
class DataHolder: NSObject {
    
    var delegate: DHDelegate?
    
    static let sharedInstance:DataHolder = DataHolder()
    var handle: AuthStateDidChangeListenerHandle? //var to handle the AUTHENTICATION STATE LISTENER:
    var userAuth:User?
    var db: Firestore!
    
    
    func initFirebase(){
        FirebaseApp.configure()
        db = Firestore.firestore()
    }
    
    func didUserStateChange() {
        //We set a listener on the FIRAuth obj go get current USER STATE
        //this listener gets called whenever the user's sing-in state changes
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // User is signed in.
                DataHolder.sharedInstance.userAuth=user
                self.delegate?.DHUserLogin(usr: user)
            } else {
                // No user is signed in.
            }
        }
    }
    
    func detachStateListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}
