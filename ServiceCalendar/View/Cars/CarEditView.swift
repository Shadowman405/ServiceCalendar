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
                                .frame( height: UIScreen.main.bounds.height/2.5)
                                .cornerRadius(30)
                                .scaledToFit()
                                .padding()
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height/2.9)
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
                                .keyboardType(.default)
                        }
                        Section(header: Text("Enter car model")) {
                            TextField("Car model...", text: $carModel)
                                .keyboardType(.default)
                        }
                        Section(header: Text("Enter car mileage")) {
                            TextField("Mileage...", text: $carMileage)
                                .keyboardType(.numberPad)
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height/2.9)
                    .cornerRadius(20)
                    .padding()
                    
                    HStack(alignment: .center) {
                        Button {
                            print("updated=")
                        } label: {
                            Text("Update")
                        }
                        .foregroundColor(.black)
                        .background(.green)
                        .padding()
                    .cornerRadius(20)
                    }
                }
            }
        }
        .onAppear{
            downloadImages(from: imagesArray)
        }
    }
    
    func downloadImages(from strings: [String]) {
        var imgUrls = [URL]()
        
        for i in 0..<strings.count {
            guard let url = URL(string: strings[i]) else {return}
            imgUrls.append(url)
            
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: imgUrls[i]) else { return}
                DispatchQueue.main.async {
                    selectedImages.append(UIImage(data: data)!)
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
