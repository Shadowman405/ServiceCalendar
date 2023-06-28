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

class FireBaseHelper {
    static let shared = FireBaseHelper()
    
    
    //MARK: - Add
    func addNewService(selectedCar: Car,mileage: String,
                       date: Date, isDone: Bool, checkMoney: String,serviceType: String, serviceDescription: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        let uniqueID = "\(uid)\(selectedCar.carName)\(selectedCar.carModel)"
        let uniqueService = "\(uid)\(date)"
        let serviceData = [
            "mileage":mileage ,
            "date": date,
            "isDone": isDone,
            "checkMoney": checkMoney,
            "serviceType": serviceType,
            "serviceDescription": serviceDescription
        ] as [String : Any]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).collection("cars").document(uniqueID).collection("Services").document(uniqueService).setData(serviceData)  { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
    
    //MARK: - Delete
    func deleteService(selectedCar: Car, selectedService: Service ) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return }
        let uniqueID = "\(uid)\(selectedCar.carName)\(selectedCar.carModel)"
        let uniqueService = "\(uid)\(selectedService.date)"
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document(uniqueID).collection("Services").document(uniqueService).delete()
    }
    
    //MARK: - Replace ( added for edit view - replace current servicee when date is changing)
    func replaceNewService(selectedCar: Car, selectedService: Service, mileage: String,
                       date: Date, isDone: Bool, checkMoney: String,serviceType: String, serviceDescription: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        let uniqueID = "\(uid)\(selectedCar.carName)\(selectedCar.carModel)"
        let uniqueService = "\(uid)\(date)"
        let serviceData = [
            "mileage":mileage ,
            "date": date,
            "isDone": isDone,
            "checkMoney": checkMoney,
            "serviceType": serviceType,
            "serviceDescription": serviceDescription
        ] as [String : Any]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).collection("cars").document(uniqueID).collection("Services").document(uniqueService).setData(serviceData)  { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
    
    //MARK: - Update
    func updateService(selectedCar: Car, selectedService: Service, mileage: String,
                       date: Date, isDone: Bool, checkMoney: String,serviceType: String, serviceDescription: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        let uniqueID = "\(uid)\(selectedCar.carName)\(selectedCar.carModel)"
        let uniqueService = "\(uid)\(selectedService.date)"
        let serviceData = [
            "mileage":mileage ,
            "date": date,
            "isDone": isDone,
            "checkMoney": checkMoney,
            "serviceType": serviceType,
            "serviceDescription": serviceDescription
        ] as [String : Any]
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document(uniqueID).collection("Services").document(uniqueService).setData(serviceData)
    }
}
