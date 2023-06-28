//
//  Helpers.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 28.06.23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class Helper {
    //let manager = FirebaseManager()
    
    static let shared = Helper()
    
    
    func deleteService(selectedCar: Car, selectedService: Service ) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return }
        let uniqueID = "\(uid)\(selectedCar.carName)\(selectedCar.carModel)"
        let uniqueService = "\(uid)\(selectedService.date)"
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document(uniqueID).collection("Services").document(uniqueService).delete()
    }
}
