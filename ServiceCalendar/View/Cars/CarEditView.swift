//
//  CarEditView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 1.07.23.
//

import SwiftUI
import PhotosUI

struct CarEditView: View {
    var selectedCar: Car
    @Environment(\.dismiss) var dismiss
    @State var carMark : String
    @State var carModel : String
    @State var carMileage : String
    @State var carPhoto: [PhotosPickerItem] = []
    @State var selectedImages: [UIImage] = []
    @State var imagesArray : [String]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.clear, Color.blue, Color.purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                PhotosPicker(selection: $carPhoto) {
                    Text("Add photo")
                        .foregroundColor(.orange)
                }
                .onChange(of: carPhoto) { newItem in
                    for item in carPhoto {
                        Task{
                            if let data = try? await item.loadTransferable(type: Data.self){
                                if let uiImage = UIImage(data: data){
                                    selectedImages.append(uiImage)
                                }
                            }
                        }
                    }
                }
                
                if !selectedImages.isEmpty {
                    TabView {
                        ForEach(0..<selectedImages.count, id: \.self) { i in
                            Image(uiImage: selectedImages[i])
                                .resizable()
                                .frame(height: 320)
                                .cornerRadius(30)
                                .scaledToFit()
                                .padding()
                        }
                    }
                    .frame(height: 320)
                    .tabViewStyle(.page)
                } else {
                    Image(systemName: "photo.on.rectangle")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                
                VStack(alignment: .leading,spacing: 10) {
                    Form {
                        Section(header: Text("Enter car mark")) {
                            TextField("Car mark...", text: $carMark)
                                .keyboardType(.numberPad)
                        }
                        Section(header: Text("Enter car model")) {
                            TextField("Car model...", text: $carModel)
                                .keyboardType(.numberPad)
                        }
                        Section(header: Text("Enter car mileage")) {
                            TextField("Mileage...", text: $carMileage)
                                .keyboardType(.numberPad)
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height/3)
                    .cornerRadius(20)
                    .padding()
                }
            }
        }
    }
}

struct CarEditView_Previews: PreviewProvider {
    static var previews: some View {
        CarEditView(selectedCar: FireBaseHelper().mockCar, carMark: FireBaseHelper().mockCar.carName, carModel: FireBaseHelper().mockCar.carModel, carMileage: String(FireBaseHelper().mockCar.carMileage), imagesArray: FireBaseHelper().mockCar.carImage)
    }
}
