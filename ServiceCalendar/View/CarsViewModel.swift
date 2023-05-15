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
    }
}
