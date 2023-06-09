//
//  ServicesCostAllWidget.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 7.06.23.
//

import SwiftUI

struct ServicesCostAllWidget: View {
    var descriptionText = ""
    var sumText = ""
    var services = [Service]()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Gradient(colors: [Color.purple, Color.blue]).opacity(1))
                .frame(width: 200, height: 240)
                .shadow(color: .black.opacity(0.25), radius: 10,x: 5, y: 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(0.5))
                        .blendMode(.overlay)
                }
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25),lineWidth: 1,offsetX: 1,offsetY: 1,blur: 0,blendMode: .overlay)
            
            VStack {
                Text("Spended money\n on service for all time:")
                    .padding()
                Text("\(allTimeCostOfServices())")
            }
        }
    }
    
    func allTimeCostOfServices() -> String {
        var sum = 0
        
        for service in services {
            sum += service.checkMoney
        }
        return "\(sum)"
    }
    
    func allTimeCostOfGasoline() -> String {
        let serviceType = ServiceType()
        var sum = 0
        
        for service in services {
            if service.serviceType == serviceType.gasoline {
                sum += service.checkMoney
            }
        }
        return "\(sum)"
    }
}

struct ServicesCostAllWidget_Previews: PreviewProvider {
    static var previews: some View {
        ServicesCostAllWidget(services: [Service(mileage: 20300, date: Date(), doneService: false, checkMoney: 110, serviceType: "Service", serviceDescription: "Beep")])
    }
}
