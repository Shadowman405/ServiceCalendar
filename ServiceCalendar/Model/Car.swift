//
//  Car.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 7.04.23.
//

import Foundation
import SwiftUI

class CarGrid: ObservableObject {
   // @Published var cars: [Car] = getAllCars()
    @Published var cars: [Car] = [
        Car(carName: "Mercedes-Benz",carModel: "S203", carImage: ["MB"], carMileage: 205000),
        Car(carName: "Honda",carModel: "Accord", carImage: ["Honda"], carMileage: 155000),
        Car(carName: "Toyota",carModel: "Camry", carImage: ["Toyota"], carMileage: 2000)
    ] 
    
    func saveCar(carName: String,carModel: String ,carImg: [String], carMileAge: Int) {
        let newCar = Car(carName: carName,carModel:carModel, carImage: carImg, carMileage: carMileAge)
        cars.append(newCar)
    }
}

struct Car: Identifiable, Codable {
    var id = UUID()
    var carName: String
    var carModel: String
    var carImage: [String]
    var carMileage: Int
}

//func getAllCars() -> [Car] {
//    let cars = [
//        Car(carName: "Mercedes-Benz", carImage: "MB", carMileage: 205000),
//        Car(carName: "Honda", carImage: "Honda", carMileage: 155000),
//        Car(carName: "Toyota", carImage: "Toyota", carMileage: 2000)
//    ]
//    
//    return cars
//}
