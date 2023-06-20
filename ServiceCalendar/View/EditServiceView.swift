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
            
            VStack {
                Form{
                    Section("Mileage") {
                        TextField("mileage", text: $mileage)
                    }
                    Section("Date") {
                        DatePicker("Select Date", selection: $date)
                            .datePickerStyle(.compact)
                    }
                    Section("Is service Done?") {
                        Toggle("Is service done?", isOn: $isDone)
                            .accentColor(.green)
                    }
                    Section("Check Money") {
                        TextField("mileage", text: $checkMoney)
                    }
                    Section("Service type") {
                        Picker("Choose type of service", selection: $serviceType) {
                            ForEach(typeOfServices, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Section("Service Description") {
                        TextField("mileage", text: $serviceDescription, axis: .vertical)
                            .lineLimit(200)
                            .background(Color.green.opacity(0.2))
                    }
                    Button("Save") {
                        print("Suck bebra")
                    }
                    .foregroundColor(.green)
                }
                .padding()
                .cornerRadius(20)
                
            }
        }
        .ignoresSafeArea()
    }
}

struct EditServiceView_Previews: PreviewProvider {
    static var previews: some View {
        EditServiceView(selectedService: Service(mileage: 200000, date: .now, doneService: true, checkMoney: 200,serviceType: "Documents", serviceDescription: "InsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsurance"), mileage: "100", date: Date.now, isDone: true, checkMoney: "200", serviceType: "Service", serviceDescription: "beep")
    }
}