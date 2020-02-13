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

//static class that will maintain data consistency between views
class DataHolder: NSObject {
    
    static let sharedInstance:DataHolder = DataHolder()
    //var to handle the AUTHENTICATION STATE LISTENER:
    var handle: AuthStateDidChangeListenerHandle?
    
    func initFirebase(){
        FirebaseApp.configure()
    }
    
    func didUserStateChange() {
        //We set a listener on the FIRAuth obj go get current USER STATE
        //this listener gets called whenever the user's sing-in state changes
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
        }
    }
    
    func detachStateListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}
