//
//  FirebaseManager.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 12.05.23.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseManager: NSObject {
    let auth: Auth
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
}
