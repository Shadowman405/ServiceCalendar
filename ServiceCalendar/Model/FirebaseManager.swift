//
//  FirebaseManager.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 12.05.23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class FirebaseManager: NSObject {
    let auth: Auth
    let firestore: Firestore
    let storage: Storage
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.storage = Storage.storage()
        
        super.init()
    }
    
    
    func deleteService(selectedCar: Car, selectedService: Service) {
        guard let uid = Auth.auth().currentUser?.uid else {return }
        let uniqueID = "\(uid)\(selectedCar.carName)\(selectedCar.carModel)"
        let uniqueService = "\(uid)\(selectedService.date)"
        
        Firestore.firestore().collection("users").document(uid).collection("cars").document(uniqueID).collection("Services").document(uniqueService).delete()
    }
}
