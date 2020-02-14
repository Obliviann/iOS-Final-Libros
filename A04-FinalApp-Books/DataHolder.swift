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
    //https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseUser.html
    //Represents a user. Fb Auth does not attempt to validate users when loading them from the keychain.
    func DHUserLogin(userr: User)
}

//static class that will maintain data consistency between views
class DataHolder: NSObject {
    
    var delegate: DHDelegate?
    
    //1
    static let sharedInstance:DataHolder = DataHolder()
    //listener to handle the AUTH STATE. Gets called whenever the user's sing-in state changes
    //A handle useful for manually unregistering the block as a listener.
    //Never used??
    var handle: AuthStateDidChangeListenerHandle?
    var firUser:User?
    var db: Firestore!
    
    
    func initFirebase(){
        FirebaseApp.configure()
        db = Firestore.firestore()
    //}
    
        //TODO: NOT ACTUALLY USING THIS ??
    //func didUserStateChange() {
        //We set a listener on the FIRAuth obj to GET THE CURRENTLY SIGNED-IN USER
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            //Eliminamos el opcional ?, y con ello su posibilidad de que sea nil, a 'user' type User. same as if user !=    ???
            if let usr = user {
                // User is signed in.
                DataHolder.sharedInstance.firUser = usr //whynot self (bcs of static       ?????)
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
