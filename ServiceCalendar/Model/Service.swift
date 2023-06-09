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
    var serviceType: String
    var serviceDescription: String
    
    var icon: String {
        switch doneService {
        case true:
            return "checkmark.circle.fill"
        case false:
            return "checkmark.circle"
        }
    }
}

struct ServiceType {
    let gasoline = "Gasoline"
    let service = "Service"
    let documents = "Documents"
    let other = "Other"
    
    let serviceIcon = "pipe"
    let gasolineIcon = "gasoline"
    let documentsIcon = "documents"
    let ohterIcon = "other"
    
    
    
    // MARK: - func for widget in forecastView
    
    //All time service
    func allTimeCostOfServices(services: [Service]) -> String {
        let serviceType = ServiceType()
        var sum = 0
        
        for service in services {
            if service.serviceType == serviceType.service {
                sum += service.checkMoney
            }
        }
        return "\(sum)"
    }
    
    //All time gasoline
    func allTimeCostOfGasoline(services: [Service]) -> String {
        let serviceType = ServiceType()
        var sum = 0
        
        for service in services {
            if service.serviceType == serviceType.gasoline {
                sum += service.checkMoney
            }
        }
        return "\(sum)"
    }
    
    //All time documents
    func allTimeCostOfDocuments(services: [Service]) -> String {
        let serviceType = ServiceType()
        var sum = 0
        
        for service in services {
            if service.serviceType == serviceType.documents {
                sum += service.checkMoney
            }
        }
        return "\(sum)"
    }
    
    //All time other
    func allTimeCostOfOther(services: [Service]) -> String {
        let serviceType = ServiceType()
        var sum = 0
        
        for service in services {
            if service.serviceType == serviceType.other {
                sum += service.checkMoney
            }
        }
        return "\(sum)"
    }
    
    //MARK: - Sorted by month
    func allTimeCostOfServicesMonth(services: [Service]) -> String {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let yearMonth = DateComponents(year: year, month: month)
        let filteredService = services.filter {
            Calendar.current.dateComponents([.year,.month], from: $0.date) == yearMonth
        }
        
        let serviceType = ServiceType()
        var sum = 0
        
        for service in filteredService {
            if service.serviceType == serviceType.service {
                sum += service.checkMoney
            }

        }
        return "\(sum)"
    }
    
    //gasoline
    func allTimeCostOfGasolineMonth(services: [Service]) -> String {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let yearMonth = DateComponents(year: year, month: month)
        let filteredService = services.filter {
            Calendar.current.dateComponents([.year,.month], from: $0.date) == yearMonth
        }
        
        let serviceType = ServiceType()
        var sum = 0
        
        for service in filteredService {
            if service.serviceType == serviceType.gasoline {
                sum += service.checkMoney
            }
        }
        return "\(sum)"
    }
    
    //documents
    func allTimeCostOfDocumentsMonth(services: [Service]) -> String {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let yearMonth = DateComponents(year: year, month: month)
        let filteredService = services.filter {
            Calendar.current.dateComponents([.year,.month], from: $0.date) == yearMonth
        }
        
        let serviceType = ServiceType()
        var sum = 0
        
        for service in filteredService {
            if service.serviceType == serviceType.documents {
                sum += service.checkMoney
            }
        }
        return "\(sum)"
    }
    
    // other
    func allTimeCostOfOtherMonth(services: [Service]) -> String {
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let yearMonth = DateComponents(year: year, month: month)
        let filteredService = services.filter {
            Calendar.current.dateComponents([.year,.month], from: $0.date) == yearMonth
        }
        
        let serviceType = ServiceType()
        var sum = 0
        
        for service in filteredService {
            if service.serviceType == serviceType.other {
                sum += service.checkMoney
            }
        }
        return "\(sum)"
    }
}

extension ServiceSegmentedControlModel {
    static let mockService: [Service] = [
        Service(mileage: 220000, date: .init(timeIntervalSinceNow: 0), doneService: true, checkMoney: 150,serviceType: "Gasoline", serviceDescription: "Beep"),
        Service(mileage: 230000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 110,serviceType: "Gasoline", serviceDescription: "Beep"),
        Service(mileage: 250000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 940,serviceType: "Gasoline", serviceDescription: "Beep"),
        Service(mileage: 260000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 100,serviceType: "Gasoline", serviceDescription: "Beep"),
        Service(mileage: 1264000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 66,serviceType: "Gasoline", serviceDescription: "Beep")
    ]
}

extension Service {
    static let mockService: [Service] = [
        Service(mileage: 220000, date: .init(timeIntervalSinceNow: 0), doneService: true, checkMoney: 150,serviceType: "Gasoline", serviceDescription: "Beep"),
        Service(mileage: 230000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 110,serviceType: "Gasoline", serviceDescription: "Beep"),
        Service(mileage: 250000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 940,serviceType: "Gasoline", serviceDescription: "Beep"),
        Service(mileage: 260000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 100,serviceType: "Gasoline", serviceDescription: "Beep"),
        Service(mileage: 1264000, date: .init(timeIntervalSinceNow: 0), doneService: false, checkMoney: 66,serviceType: "Gasoline", serviceDescription: "Beep")
    ]
}
