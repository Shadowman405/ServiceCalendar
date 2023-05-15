//
//  ServiceList.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 6.04.23.
//

import SwiftUI
import Firebase

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
                        ForEach(carGrid.cars){ car in
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
}

class CarsViewModel: ObservableObject {
    @Published var errorMesage = ""
    @Published var decodedCar: Car?
    
    init() {
        fetchCars()
    }
    
    private func fetchCars() {
        let decoder = JSONDecoder()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document(uid).getDocument { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = snapshot?.data() else { return}
            
            let uid = data["uid"] as? String ?? ""
            let carName = data["carMark"] as? String ?? ""
            let carModel = data["carModel"] as? String ?? ""
            let carMileage = data["carMilage"] as? String ?? ""
            let carImage = data["carImage"] as? String ?? ""
            
            let decodedCar = Car(carName: carName, carModel: carModel, carImage: [carImage], carMileage: Int(carMileage) ?? 0)
            
            print(decodedCar)
        }
    }
}




struct ServiceList_Previews: PreviewProvider {
    static var previews: some View {
        CarsGrid(carGrid: CarGrid())
    }
}
