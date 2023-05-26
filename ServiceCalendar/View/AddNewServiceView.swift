//
//  AddNewServiceView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 26.05.23.
//

import SwiftUI

struct AddNewServiceView: View {
    @State private var mileage = ""
    @State private var date = Date()
    @State private var isDone = false
    @State private var checkMoney = ""
    
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            HStack {
                Text("Enter Mileage")
                    .padding()
                Spacer()
                TextField("Mileage...", text: $mileage)
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
                Text("Enter cost of service")
                    .padding()
                Spacer()
                TextField("Service cost...", text: $checkMoney)
                    .keyboardType(.numberPad)
            }
        }
    }
}

struct AddNewServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewServiceView()
    }
}
