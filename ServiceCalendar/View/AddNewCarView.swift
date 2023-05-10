//
//  AddNewCarView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 9.05.23.
//

import SwiftUI
import PhotosUI

struct AddNewCarView: View {
    @State private var carMark : String = ""
    @State private var carModel : String = ""
    @State private var carMileage : String = ""
    @State private var carPhoto: [PhotosPickerItem] = []
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.clear ,Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                PhotosPicker(selection: $carPhoto) {
                    Image(systemName: "photo.stack")
                        .resizable()
                        .frame(width: 200,height: 200)
                        .foregroundColor(.black)
                }
                .onChange(of: carPhoto[0]) { newItem in
                    Task{
                        if let data = try? await newItem.loadTransferable(type: Data.self){
                            selectedImageData = data
                        }
                    }
                }
                
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
                    HStack {
                        Text("Choose Car photos")
                            .padding()
                    }
                }
            }
        }
    }
}

struct AddNewCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCarView()
    }
}
