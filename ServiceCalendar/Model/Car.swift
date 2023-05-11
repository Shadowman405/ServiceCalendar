//
//  Car.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 7.04.23.
//

import Foundation
import SwiftUI

final class CarGrid: ObservableObject {
   // @Published var cars: [Car] = getAllCars()
    @Published var cars: [Car] = [
        Car(carName: "Mercedes-Benz", carImage: "MB", carMileage: 205000),
        Car(carName: "Honda", carImage: "Honda", carMileage: 155000),
        Car(carName: "Toyota", carImage: "Toyota", carMileage: 2000)
    ]
}

struct Car: Hashable,Codable, Identifiable {
    var id = UUID()
    var carName: String
    var carImage: String
    var carMileage: Int
}

func getAllCars() -> [Car] {
    let cars = [
        Car(carName: "Mercedes-Benz", carImage: "MB", carMileage: 205000),
        Car(carName: "Honda", carImage: "Honda", carMileage: 155000),
        Car(carName: "Toyota", carImage: "Toyota", carMileage: 2000)
    ]
    
    return cars
}
