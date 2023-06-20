//
//  EditServiceView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 20.06.23.
//

import SwiftUI

struct EditServiceView: View {
    var selectedService : Service
    var typeOfServices = ["Gasoline", "Service", "Documents", "Other"]
    
    @State var mileage: String
    @State var date: Date
    @State var isDone: Bool
    @State var checkMoney: String
    @State var serviceType: String
    @State var serviceDescription: String
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.clear,Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
            
            Form{
                Section("Mileage") {
                    TextField("mileage", text: $mileage)
                }
                Section("Date") {
                    DatePicker("Select Date", selection: $date)
                }
                Section("Is service Done?") {
                    Toggle("Is service done?", isOn: $isDone)
                }
                Section("Check Money") {
                    TextField("mileage", text: $checkMoney)
                }
                Section("Service type") {
                    TextField("mileage", text: $serviceType)
                }
                Section("Service Description") {
                    TextField("mileage", text: $serviceDescription)
                }
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

struct EditServiceView_Previews: PreviewProvider {
    static var previews: some View {
        EditServiceView(selectedService: Service(mileage: 200000, date: .now, doneService: true, checkMoney: 200,serviceType: "Documents", serviceDescription: "InsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsurance"), mileage: "100", date: Date.now, isDone: true, checkMoney: "200", serviceType: "Service", serviceDescription: "beep")
    }
}
