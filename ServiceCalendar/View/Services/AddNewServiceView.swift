//
//  AddNewServiceView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 26.05.23.
//

import SwiftUI

struct AddNewServiceView: View {
    @Environment(\.dismiss) var dismiss
    @State private var mileage = ""
    @State private var date = Date()
    @State private var isDone = false
    @State private var checkMoney = ""
    @State private var serviceDescription = ""
    @State private var serviceType = "Service"
    var typeOfServices = ["Gasoline", "Service", "Documents", "Other"]
    
    var selectedCar: Car?
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.clear, Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading,spacing: 10) {
                    HStack {
                        Text("Enter Mileage")
                            .padding()
                        Spacer()
                        TextField("Mileage...", text: $mileage)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        DatePicker("Select Date", selection: $date)
                            .padding()
                            .datePickerStyle(.compact)
                    }
                    HStack {
                        Picker("Choose type of service", selection: $serviceType) {
                            ForEach(typeOfServices, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding()
                    HStack {
                        Text("Enter cost of service")
                            .padding()
                        Spacer()
                        TextField("Service cost...", text: $checkMoney)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Toggle("Is service done?", isOn: $isDone)
                            .padding()
                    }
                    HStack {
                        TextField("Description", text: $serviceDescription,prompt: Text("Please enter description text..."), axis: .vertical)
                            .lineLimit(200)
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding()
                }
                
                Button {
                    guard let car = selectedCar else { return}
                    FireBaseHelper().addNewService(selectedCar: car, mileage: mileage, date: date, isDone: isDone, checkMoney: checkMoney, serviceType: serviceType, serviceDescription: serviceDescription)
                    dismiss()
                } label: {
                    Text("Add new service")
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.black)
            }
        }
        .navigationTitle("Add New Service")
        .tint(.blue)
    }
}

struct AddNewServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewServiceView(selectedCar: FireBaseHelper().mockCar)
    }
}
