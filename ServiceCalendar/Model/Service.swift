//
//  Service.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 18.04.23.
//

import Foundation

enum ServiceSegmentedControlModel {
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

extension ServiceSegmentedControlModel {
    static let mockService: [Service] = [
        Service(mileage: 220000, date: .init(timeIntervalSinceNow: 0), doneService: true, checkMoney: 150),
        Service(mileage: 230000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 110),
        Service(mileage: 250000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 940),
        Service(mileage: 260000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 100),
        Service(mileage: 264000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 66)
    ]
}
