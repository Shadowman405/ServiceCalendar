//
//  ServicesCostAllWidget.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 7.06.23.
//

import SwiftUI

struct ServicesCostAllWidget: View {
    var services = [Service]()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ServicesCostAllWidget_Previews: PreviewProvider {
    static var previews: some View {
        ServicesCostAllWidget(services: [Service(mileage: 20300, date: Date(), doneService: false, checkMoney: 110, serviceType: "Service", serviceDescription: "Beep")])
    }
}
