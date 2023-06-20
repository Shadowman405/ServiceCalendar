//
//  EditServiceView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 20.06.23.
//

import SwiftUI

struct EditServiceView: View {
    var selectedService : Service
    @State var mileage = ""
    
    init(selectedService: Service, mileage: String = "") {
        self.selectedService = selectedService
        self.mileage = "\(self.selectedService.mileage)"
    }
    
    
    
    var body: some View {
        
        
        ZStack {
            LinearGradient(colors: [Color.clear,Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
            
            Form{
                TextField("mileage", text: $mileage)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

struct EditServiceView_Previews: PreviewProvider {
    static var previews: some View {
        EditServiceView(selectedService: Service(mileage: 200000, date: .now, doneService: true, checkMoney: 200,serviceType: "Documents", serviceDescription: "InsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsurance"))
    }
}
