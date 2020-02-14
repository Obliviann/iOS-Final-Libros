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
    //A handle useful for manually unregistering the block as a listener.
    //TODO: Never used??
    var handle: AuthStateDidChangeListenerHandle?
    var firUser:User?
    var db: Firestore!
    
    
    func initFirebase(){
        FirebaseApp.configure()
        db = Firestore.firestore()
    //}
    
    //func didUserStateChange() {
        //TODO: what are we using this for in the DH ??
                //We set a listener on the FIRAuth obj to GET THE CURRENTLY SIGNED-IN USER
                //Ensures the object isn't in an intermediate state—such as initialization—when you get the current user
                //Gets called whenever the user's sing-in/auth state changes
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            //Eliminamos el opcional ? aka su posibilidad de que sea nil, a 'user' type User.
            //TODO: same as if user !=    ???
            if let usr = user {
                //TODO: why?
                DataHolder.sharedInstance.firUser = usr //whynot self (bcs of static       ?????)
                self.delegate?.DHUserLogin(userr: usr)
            }
        }
        //same as (but better):
        //let user = Auth.auth().currentUser
        //   if let usr = user {
        
        //   }
    }
    
    func detachStateListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}
