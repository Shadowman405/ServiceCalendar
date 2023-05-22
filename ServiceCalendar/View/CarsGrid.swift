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
                            NavigationLink(destination: SelectedCar(selectedCar: car)) {
                                CarCell(car: car)
                                }
                        }
                    }
                }
                .background(LinearGradient(colors: [Color.blue,Color.purple], startPoint: .top, endPoint: .bottom))
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink {
                        LoginView(logedIn: $isUserLoggedIn)
                    } label: {
                        Text("Signout")
                            .foregroundColor(.black)
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddNewCarView()
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.black)
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        printInfo()
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundColor(.black)
                    }

                }
            }
            .navigationTitle("My Cars")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground( .blue, for: .navigationBar)
        }
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
    
    func printInfo() {
        print(viewModel.decodedCar[0].carName)
        print(viewModel.decodedCar[0].carImage)
    }
}

class CarsViewModel: ObservableObject {
    @Published var errorMesage = ""
    @Published var decodedCar: [Car] = []
    
    init() {
       // fetchCars()
        //fetchCarsArray()
        fetchCarsArrayNested()
    }
    
//    private func fetchCars() {
//        //let decoder = JSONDecoder()
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
//
//        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document(uid).getDocument { snapshot, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            guard let data = snapshot?.data() else { return}
//
//            let uid = data["uid"] as? String ?? ""
//            let carName = data["carMark"] as? String ?? ""
//            let carModel = data["carModel"] as? String ?? ""
//            let carMileage = data["carMilage"] as? String ?? ""
//            let carImage = data["carImage"] as? String ?? ""
//
//            self.decodedCar.append(contentsOf: [Car(carName: carName, carModel: carModel, carImage: [carImage], carMileage: Int(carMileage) ?? 0)])
//
//            print(self.decodedCar)
//        }
//    }
    
    
    func fetchCarsArray() {
        self.decodedCar = []
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
              let carMileage = data["carMilage"] as? String ?? ""
              let carImage = data["carImage"] as? [String] ?? [""]
              
              decodedCars.append(contentsOf: [Car(carName: carName, carModel: carModel, carImage: carImage, carMileage: Int(carMileage) ?? 0)])
          }
          
          self.decodedCar = decodedCars
          decodedCars = []
        }
    }
    
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
              let carMileage = data["carMilage"] as? String ?? ""
              if let image = data["carImage"] as? [String:Any] {
//                  let carImage = image["carImage"] as? String ?? ""
//                  print("IMAGE " + carImage)
//                  someImgs.append(carImage)
                  if let nestedImg = image["carImage"] as? [String] {
                      someImgs = nestedImg
                      print(nestedImg)
                      
                  }
              }
              
              decodedCars.append(contentsOf: [Car(carName: carName, carModel: carModel, carImage: someImgs , carMileage: Int(carMileage) ?? 0)])
          }
          
          self.decodedCar = decodedCars
          //print("Car Img " + self.decodedCar[0].carImage[0])
          decodedCars = []
        }
    }
}




struct ServiceList_Previews: PreviewProvider {
    static var previews: some View {
        CarsGrid(carGrid: CarGrid())
    }
}
