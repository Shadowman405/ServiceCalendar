//
//  AddNewCarView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 9.05.23.
//

import SwiftUI

struct AddNewCarView: View {
    @State private var carMark : String = ""
    @State private var carModel : String = ""
    @State private var carMileage : String = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading,spacing: 10) {
                HStack {
                    Text("Enter Car mark")
                        .padding()
                    Spacer()
                    TextField("Mark...", text: $carMark)
                }
                HStack {
                    Text("Enter Car model")
                        .padding()
                    Spacer()
                    TextField("Model...", text: $carModel)
                }
                HStack {
                    Text("Enter Car mileage")
                        .padding()
                    Spacer()
                    TextField("Mileage...", text: $carMileage)
                        .keyboardType(.numberPad)
                }
                Text("Choose Car photos")
            }
        }
    }
}

struct AddNewCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCarView()
    }
}
