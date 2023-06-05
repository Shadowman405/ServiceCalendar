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
        //                Text("Enter date")
        //                    .padding()
        //                Spacer()
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
    //                    Text("Is service done?")
    //                        .padding()
    //                    Spacer()
                        Toggle("Is service done?", isOn: $isDone)
                            .padding()
                    }
                }
                
                Button {
                    print("beep")
                    print("\(date)")
                    addNewService()
                    dismiss()
                } label: {
                    Text("Add new service")
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.black)
            }
            
        }
    }
    
    func addNewService() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        let uniqueID = "\(uid)\(selectedCar!.carName)\(selectedCar!.carModel)"
        let uniqueService = "\(uid)\(date)"
        let serviceData = [
            "mileage":mileage ,
            "date": date,
            "isDone": isDone,
            "checkMoney": checkMoney
        ] as [String : Any]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).collection("cars").document(uniqueID).collection("Services").document(uniqueService).setData(serviceData)  { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
}

struct AddNewServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewServiceView(selectedCar: Car(carName: "Mercedes-Benz", carModel: "S203", carImage: ["MB"], carMileage: 205000))
    }
}
