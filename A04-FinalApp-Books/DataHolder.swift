//
//  DataHolder.swift
//  A04-FinalApp-Books
//
//  Created by Olivia Sartorius Freschet on 12/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit
import Firebase

//static class that will maintain data consistency between views
class DataHolder: NSObject {
    
    static let sharedInstance:DataHolder = DataHolder()
    
    func initFirebase(){
        FirebaseApp.configure()
    }
}
