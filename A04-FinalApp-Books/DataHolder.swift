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
import CoreData

//2
protocol DHDelegate {
    //https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseUser.html
    //Represents a user. Fb Auth does not attempt to validate users when loading them from the keychain.
    //func DHUserLogin(userr: User)                         TODO: do not understand this function
}

//static class that will maintain data consistency between views
class DataHolder: NSObject {
    
    //var delegate: DHDelegate?
    
    //1
    static let sharedInstance:DataHolder = DataHolder()
    //A handle useful for manually unregistering the block as a listener.
    //var handle: AuthStateDidChangeListenerHandle?         TODO: do not understand how to use it
    var firUser: User?
    var db: Firestore!
    var settings: FirestoreSettings!
    //to specify which DB doc we want to put data in
    var docRef: DocumentReference? = nil
    
    func initFirebase(){
        FirebaseApp.configure()
        db = Firestore.firestore()
        //*
        settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    //}
    
    //func didUserStateChange() {
        //We set a listener on the FIRAuth obj to GET THE CURRENTLY SIGNED-IN USER
        //Ensures the object isn't in an intermediate state—such as initialization—when you get the current user
        //Gets called whenever the user's sing-in/auth state changes
        Auth.auth().addStateDidChangeListener { (auth, user) in //**
            print("listener called")
            //Eliminamos el opcional ? aka su posibilidad de que sea nil, a 'user' type User.
            //Same as: if user != nil
            if let usr = user {
                //le asignamos la var declarada de tipo User, el valor que nos devuelve el listener
                DataHolder.sharedInstance.firUser = usr
                //self.delegate?.DHUserLogin(userr: usr)
            }
        }
        //** same as (but better than):
        //let user = Auth.auth().currentUser
        //if let usr = user { ... }
    }
    
//    func detachStateListener() {
//        Auth.auth().removeStateDidChangeListener(handle!)
//    }

}

/* With this change, timestamps stored in Cloud Firestore will be read back as Firebase Timestamp objects instead of as system Date objects. So you will also need to update code expecting a Date to instead expect a Timestamp. For example:
 // old:
 let date: Date = documentSnapshot.get("created_at") as! Date
 // new:
 let timestamp: Timestamp = documentSnapshot.get("created_at") as! Timestamp
 let date: Date = timestamp.dateValue()
 Please audit all existing usages of Date when you enable the new behavior. In a future release, the behavior will be changed to the new behavior, so if you do not follow these steps, YOUR APP MAY BREAK.*/
