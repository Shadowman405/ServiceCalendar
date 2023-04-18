//
//  Service.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 18.04.23.
//

import Foundation

enum ServiceSegmentedControl {
    case service
    case spendedMoney
}

struct Service: Identifiable {
    var id = UUID()
    var mileage: Int
    var date: Date
    var doneService: Bool
    var checkMoney: Int
}
