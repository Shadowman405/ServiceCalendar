//
//  ServiceList.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 6.04.23.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct CarsGrid: View {
    @Environment(\.dismiss) var dismiss
    @State var isUserLoggedIn : Bool = false
    @ObservedObject var carGrid: CarGrid
    @EnvironmentObject var logedInUser: isLogedInUser
    @ObservedObject private var viewModel = CarsViewModel()

    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.decodedCar){ car in
                            NavigationLink(destination: SelectedCar(bottomSheetPosition: .middle, bottomSheetChange: false, bottomSheetTranslation: 0, selectedCar: car)) {
                                CarCell(car: car)
                                }
                        }
                    }
                }
                .background(LinearGradient(colors: [Color.blue,Color.purple], startPoint: .top, endPoint: .bottom))
            }
            .toolbar {
                Menu {
                    ControlGroup{
                        // to login
                        NavigationLink {
                            LoginView(logedIn: $isUserLoggedIn)
                        } label: {
                            Label("Signout", systemImage: "person.crop.circle.badge.xmark")
                        }
                        // to add new car VC
                        NavigationLink {
                            AddNewCarView()
                        } label: {
                            Label("Add new car", systemImage: "plus.circle")
                        }
                    }
                }  label: {
                    Label("more", systemImage: "ellipsis.circle")
                }
            }
            .navigationTitle("My Cars")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground( .blue, for: .navigationBar)
        }
        .tint(.black)
    }
    
    func signOut() {
        print("Status - \(isUserLoggedIn)")
        do {
            try Auth.auth().signOut()
            print("signed out")
        } catch {
            print("Error")
        }
    }
}

class CarsViewModel: ObservableObject {
    @Published var errorMesage = ""
    @Published var decodedCar: [Car] = []
    @Published var decodedService: [Service] = []
    
    init() {
        fetchCarsArrayNested()
    }
    
//    func fetchCarsArray() {
//        self.decodedCar = []
//        var decodedCars: [Car] = []
//        
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
//      FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").addSnapshotListener { snapshot, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//        }
//            
//          let doc = snapshot!.documents
//          for eachDoc in doc {
//              let data = eachDoc.data()
//              
//              _ = data["uid"] as? String ?? ""
//              let carName = data["carMark"] as? String ?? ""
//              let carModel = data["carModel"] as? String ?? ""
//              let carMileage = data["carMilage"] as? String ?? ""
//              let carImage = data["carImage"] as? [String] ?? [""]
//              
//              decodedCars.append(contentsOf: [Car(carName: carName, carModel: carModel, carImage: carImage, carMileage: Int(carMileage) ?? 0)])
//          }
//          
//          self.decodedCar = decodedCars
//          decodedCars = []
//        }
//    }
    
    func fetchCarsArrayNested() {
        self.decodedCar = []
        var someImgs: [String] = []
        var decodedCars: [Car] = []
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
      FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
        }
            
          let doc = snapshot!.documents
          for eachDoc in doc {
              let data = eachDoc.data()
              
              _ = data["uid"] as? String ?? ""
              let carName = data["carMark"] as? String ?? ""
              let carModel = data["carModel"] as? String ?? ""
              let carMileage = data["carMileage"] as? String ?? ""
              if let image = data["carImage"] as? [String:Any] {
                  if let nestedImg = image["carImage"] as? [String] {
                      someImgs = nestedImg
                      print(carMileage)
                      
                  }
              }
              
              decodedCars.append(contentsOf: [Car(carName: carName, carModel: carModel, carImage: someImgs , carMileage: Int(carMileage) ?? 0)])
          }
          
          self.decodedCar = decodedCars
          decodedCars = []
        }
    }
    
    
}




struct ServiceList_Previews: PreviewProvider {
    static var previews: some View {
        CarsGrid(carGrid: CarGrid())
    }
}
