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
    
    let mockCar = Car(carName: "Mercedes-Benz", carModel: "S203", carImage: ["MB"], carMileage: 205000)
    let mockService = Service(mileage: 200000, date: .now, doneService: true, checkMoney: 200,serviceType: "Documents", serviceDescription: "InsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsurance")
    
    //MARK: - Service Methods
    
    //Add Service
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
    
    //Delete Service
    func deleteService(selectedCar: Car, selectedService: Service ) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return }
        let uniqueID = "\(uid)\(selectedCar.carName)\(selectedCar.carModel)"
        let uniqueService = "\(uid)\(selectedService.date)"
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document(uniqueID).collection("Services").document(uniqueService).delete()
    }
    
    //Replace Service ( added for edit view - replace current servicee when date is changing)
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
    
    //Update Service
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
    
    
    // MARK: - Cars methods
    
    //Delete Car
    func deleteCar(selectedCar: Car) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return }
        let uniqueID = "\(uid)\(selectedCar.carName)\(selectedCar.carModel)"
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document(uniqueID).delete()
    }
}
