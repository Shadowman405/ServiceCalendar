//
//  Car.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 7.04.23.
//

import Foundation
import SwiftUI

final class CarGrid: ObservableObject {
    @Published var cars: [Car] = getAllCars()
}

struct Car: Hashable,Codable, Identifiable {
    var id: Int
    var carName: String
    var carImage: String
    var carMileage: Int
}

func getAllCars() -> [Car] {
    let cars = [
        Car(id: 0, carName: "Mercedes-Benz", carImage: "MB", carMileage: 205000),
        Car(id: 1, carName: "Honda", carImage: "Honda", carMileage: 155000),
        Car(id: 2, carName: "Toyota", carImage: "Toyota", carMileage: 2000)
    ]
    
    return cars
}
