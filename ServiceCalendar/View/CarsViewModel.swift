//
//  CarsViewModel.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 15.05.23.
//

import SwiftUI

class CarsViewModel: ObservableObject {
    init() {
        fetchCars()
    }
    
    private func fetchCars() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document(uid).getDocument { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = snapshot?.data() else { return}
            print(data)
        }
    }
}
