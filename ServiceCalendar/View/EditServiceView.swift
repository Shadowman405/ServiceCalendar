//
//  EditServiceView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 20.06.23.
//

import SwiftUI

struct EditServiceView: View {
    @Environment(\.dismiss) var dismiss
    var selectedCar: Car
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
                        DatePicker("", selection: $date)
                            .datePickerStyle(.automatic)
                        
                    }
                    Section("Is service Done?") {
                        Toggle("Is service done?", isOn: $isDone)
                            .accentColor(.green)
                            .tint(.green)
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
                        if selectedService.date == date {
                            FireBaseHelper().updateService(selectedCar: selectedCar, selectedService: selectedService, mileage: mileage, date: date, isDone: isDone, checkMoney: checkMoney, serviceType: serviceType, serviceDescription: serviceDescription)
                            dismiss()
                        } else {
                            FireBaseHelper().deleteService(selectedCar: selectedCar, selectedService: selectedService)
                            FireBaseHelper().replaceNewService(selectedCar: selectedCar, selectedService: selectedService, mileage: mileage, date: date, isDone: isDone, checkMoney: checkMoney, serviceType: serviceType, serviceDescription: serviceDescription)
                            dismiss()
                        }
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
        EditServiceView(selectedCar: Car(carName: "Mercedes-Benz", carModel: "S203", carImage: ["MB"], carMileage: 205000),selectedService: Service(mileage: 200000, date: .now, doneService: true, checkMoney: 200,serviceType: "Documents", serviceDescription: "InsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsuranceInsurance"), mileage: "100", date: Date.now, isDone: true, checkMoney: "200", serviceType: "Service", serviceDescription: "beep")
    }
}
