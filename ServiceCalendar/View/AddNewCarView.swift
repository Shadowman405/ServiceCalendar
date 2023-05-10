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
    @State private var selectedImages: [Image] = []
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.clear ,Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                PhotosPicker(selection: $carPhoto) {
                    if selectedImages.count != 0 {
                        ScrollView {
                            LazyHStack {
                                ForEach(0..<selectedImages.count, id: \.self) { i in
                                    selectedImages[i]
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300, height: 300)
                                }
                            }
                        }
                    } else {
                        Image(systemName: "photo.on.rectangle")
                    }
                }
                .onChange(of: carPhoto) { newItem in
                    for item in carPhoto {
                        Task{
                            if let data = try? await item.loadTransferable(type: Data.self){
                                if let uiImage = UIImage(data: data){
                                    let image = Image(uiImage: uiImage)
                                    selectedImages.append(image)
                                }
                            }
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
                
                Button {
                    
                } label: {
                    Text("Save Car")
                        .foregroundColor(.black)
                }
                .foregroundColor(.black)

            }
        }
    }
}

struct AddNewCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCarView()
    }
}
