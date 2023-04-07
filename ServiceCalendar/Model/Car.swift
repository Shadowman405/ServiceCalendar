//
//  Car.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 7.04.23.
//

import Foundation

final class CarGrid: ObservableObject {
    
}

struct Car: Hashable,Codable, Identifiable {
    var id: Int
    var carName: String
    var carImage: String
    var carMileage: Int
}
