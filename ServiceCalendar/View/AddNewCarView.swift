//
//  AddNewCarView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 9.05.23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore

struct AddNewCarView: View {
    @Environment(\.dismiss) var dismiss
    @State private var carMark : String = ""
    @State private var carModel : String = ""
    @State private var carMileage : String = ""
    @State private var carPhoto: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @State var imagesArray : [String] = []


    
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
//                    HStack {
//                        Text("Enter Car mark")
//                            .padding()
//                        Spacer()
//                        TextField("Mark...", text: $carMark)
//                    }
//                    HStack {
//                        Text("Enter Car model")
//                            .padding()
//                        Spacer()
//                        TextField("Model...", text: $carModel)
//                    }
//                    HStack {
//                        Text("Enter Car mileage")
//                            .padding()
//                        Spacer()
//                        TextField("Mileage...", text: $carMileage)
//                            .keyboardType(.numberPad)
//                    }
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
                
                Button {
                    persistImageToStorage()
                    dismiss()
                } label: {
                    Text("Save Car")
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.black)
            }
        }
    }
    
    private func persistImageToStorage() {
        FirebaseManager.shared.auth.addStateDidChangeListener { auth, user in
            if user != nil {
                guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
//                let ref = FirebaseManager.shared.storage.reference(withPath: uid)
                
                for i in 0...selectedImages.count - 1 {
                    let ref = FirebaseManager.shared.storage.reference().child("images/\(UUID().uuidString)")
                    guard let imageData = self.selectedImages[i].jpegData(compressionQuality: 0.5) else {return}
                    ref.putData(imageData) { metadata, error in
                        if let error = error {
                            print(error)
                        }
                        
                        ref.downloadURL { url, error in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                            
                            print(url?.absoluteString ?? "")
                            
                            guard let url = url else {return}
                            
                            imagesArray.append(url.absoluteString)
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.storeUserInfo(carImg: self.imagesArray)
                }
            } else {
                print("User not logged in")
            }
        }
    }
    
    private func storeUserInfo(carImg: [String]) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        let uniqueID = "\(uid)\(self.carMark)\(self.carModel)"
        let carData = ["uid": uid,
                       "carMark": self.carMark,
                       "carModel": self.carModel,
                       "carMileage": self.carMileage,
                       "carImage" : ["carImage": carImg]] as [String : Any]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).collection("cars").document(uniqueID).setData(carData) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
    
    func uploadPhoto() {
        
    }
}

struct AddNewCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCarView()
    }
}
