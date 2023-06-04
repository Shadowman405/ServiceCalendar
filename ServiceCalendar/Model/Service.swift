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
 
struct Service: Identifiable,Hashable, Codable {
    var id = UUID()
    var mileage: Int
    var date: Date
    var doneService: Bool
    var checkMoney: Int
    
    var icon: String {
        switch doneService {
        case true:
            return "checkmark.circle.fill"
        case false:
            return "checkmark.circle"
        }
    }
    
    init( mileage: Int, date: Date, doneService: Bool, checkMoney: Int) {
        //self.id = id
        self.mileage = mileage
        self.date = date
        self.doneService = doneService
        self.checkMoney = checkMoney
    }
    
    enum CodingKeys: CodingKey {
       // case id
        case mileage
        case date
        case doneService
        case checkMoney
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //try container.encode(self.id, forKey: .id)
        try container.encode(self.mileage, forKey: .mileage)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.doneService, forKey: .doneService)
        try container.encode(self.checkMoney, forKey: .checkMoney)
    }
}

extension ServiceSegmentedControlModel {
    static let mockService: [Service] = [
        Service(mileage: 220000, date: .init(timeIntervalSinceNow: 0), doneService: true, checkMoney: 150),
        Service(mileage: 230000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 110),
        Service(mileage: 250000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 940),
        Service(mileage: 260000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 100),
        Service(mileage: 1264000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 66)
    ]
}

extension Service {
    static let mockService: [Service] = [
        Service(mileage: 220000, date: .init(timeIntervalSinceNow: 0), doneService: true, checkMoney: 150),
        Service(mileage: 230000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 110),
        Service(mileage: 250000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 940),
        Service(mileage: 260000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 100),
        Service(mileage: 1264000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 66)
    ]
}
