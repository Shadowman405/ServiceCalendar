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
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil)
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.clear ,Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                PhotosPicker(selection: $carPhoto) {
//                    if selectedImages.count != 0 {
//                        TabView {                                ForEach(0..<selectedImages.count, id: \.self) { i in
//                                    selectedImages[i]
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 100, height: 100)
//                                }
//                        }
//                    }

                        Text("Add photo")

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
                
                if !selectedImages.isEmpty {
//                    TabView {
//                        ForEach(0..<selectedImages.count, id: \.self) { i in
//                                    selectedImages[i]
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 100, height: 100)
//                                }
//                    }
                    ScrollView {
                        TabView {
                            ForEach(0..<selectedImages.count, id: \.self) { i in
                                selectedImages[i]
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 320)
                            }
                        }
                        .frame(height: 320)
                        .tabViewStyle(.page)
                    }
                } else {
                    Image(systemName: "photo.on.rectangle")
                        .resizable()
                        .frame(width: 80, height: 80)
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
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.green)
            }
        }
    }
}

struct AddNewCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCarView()
    }
}
