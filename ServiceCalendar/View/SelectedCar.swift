//
//  SelectedCar.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 11.04.23.
//

import SwiftUI
import BottomSheet
import SDWebImageSwiftUI
import Algorithms
import Firebase
import FirebaseFirestoreSwift

enum BotomSheetPosition: CGFloat, CaseIterable {
    case top = 0.82
    case middle = 0.385
}

struct SelectedCar: View {
    @Environment(\.dismiss) var dismiss
    
    @State var bottomSheetPosition: BotomSheetPosition = .middle 
    @State var bottomSheetChange = false
    @State var bottomSheetTranslation: CGFloat = BotomSheetPosition.middle.rawValue
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTranslation - BotomSheetPosition.middle.rawValue) / (BotomSheetPosition.top.rawValue - BotomSheetPosition.middle.rawValue)
    }
    
    @ObservedObject var vm: ServicesViewModel
    
    var selectedCar: Car
    
    init(bottomSheetPosition: BotomSheetPosition, bottomSheetChange: Bool = false, bottomSheetTranslation: CGFloat,selectedCar: Car) {
        //self.dismiss = dismiss
//        self.bottomSheetPosition = bottomSheetPosition
//        self.bottomSheetChange = bottomSheetChange
//        self.bottomSheetTranslation = bottomSheetTranslation
        self.vm = .init(selectedCar: selectedCar)
        self.selectedCar = selectedCar
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                
                let imageOffset = screenHeight + 36
                
                ZStack {
                    LinearGradient(colors: [.blue ,.black], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        .opacity(0.8)
                    
                    
                    VStack {
//                        Text(selectedCar.carName)
//                            .padding(25)
//                            .offset(y: -bottomSheetTranslationProrated * imageOffset)
                        
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(selectedCar.carImage, id: \.self) { img in
                                    WebImage(url: URL(string: img))
                                        .resizable()
                                        .frame(width: 300, height: 250)
                                        .cornerRadius(20)
                                        .padding()
                                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        
                    }
                    
                    
                    BottomSheetView(position: $bottomSheetPosition) {
//                        Text(bottomSheetTranslationProrated.formatted())
                        
                    } content: {
                        
                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated,selectedCar: selectedCar, selectedServices: vm.decodedService)
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                    }

                    
                    TabBar(action: {
                        bottomSheetChange.toggle()
                        bottomSheetPosition = .top
                    })
                    .offset(y: bottomSheetTranslationProrated * 115)
                }
            }
//            .toolbar(content: {
//                ToolbarItemGroup(placement: .navigationBarLeading) {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "arrowshape.turn.up.backward.2")
//                            .foregroundColor(.black)
//                    }
//
//                }
//            })
        }
        .navigationTitle(selectedCar.carName)
        //.navigationBarHidden(true)
        .onAppear(
            perform: vm.fetchServicesArray
        )
    }
}

class ServicesViewModel: ObservableObject {
    @Published var errorMesage = ""
    @Published var decodedService: [Service] = []
    var selectedCar: Car?
    
    init(selectedCar: Car?) {
        self.selectedCar = selectedCar
//        print("Selected car\n\(selectedCar?.carName ?? "some car")")
       // fetchCars()
        //fetchServicesArray()
        //fetchServiceCodable()
    }
    
    
    func fetchServicesArray() {
        self.decodedService = []
        var decodedServices: [Service] = []
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document("\(uid)\(selectedCar?.carName ?? "")\(selectedCar?.carModel ?? "")") .collection("Services").addSnapshotListener { snapshot, error in
            if let error = error {
                print("error")
                print(error.localizedDescription)
        }
            
          let doc = snapshot!.documents
          for eachDoc in doc {
              let data = eachDoc.data()
              let mileage = data["mileage"] as? String ?? ""
              let checkmoney = data["checkMoney"] as? String ?? ""
              
//              print("DATE !!!!!")
//              print(data["date"])
              
              // resolving date issue
              let time = data["date"] as? Timestamp
              let date = time?.dateValue()
              //
              
              //let date = data
              //let date = data["date"] as? Date ?? Date.now
              let isDone = data["isDone"] as? Bool ?? false
              let serviceType = data["serviceType"] as? String ?? ""
              let serviceDescription = data["serviceDescription"] as? String ?? ""
              
              decodedServices.append(Service(mileage: Int(mileage) ?? 1, date: date ?? Date.now, doneService: isDone, checkMoney: Int(checkmoney) ?? 1,serviceType: serviceType,serviceDescription: serviceDescription))
          }
            
            //let uniqued = decodedServices.uniqued()
          self.decodedService = decodedServices
          decodedServices = []
        }
    }
    
    func fetchServiceCodable() {
        self.decodedService = []
        var decodedServices: [Service] = []
        var someService = Service(mileage: 0, date: Date(), doneService: false, checkMoney: 0,serviceType: "Gasoline", serviceDescription: "Beep")
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document("\(uid)\(selectedCar?.carName ?? "")\(selectedCar?.carModel ?? "")") .collection("Services").addSnapshotListener { snapshot, error in
            if let error = error {
                print("error")
                print(error.localizedDescription)
            }
            
//            self.decodedService = snapshot!.documents.compactMap({ (QueryDocumentSnapshot) -> Service? in
//                return try? QueryDocumentSnapshot.data(as: Service.self)
//            })
            
            let doc = snapshot!.documents
            
            for eachDoc in doc {
                do {
                    someService = try! eachDoc.data(as: Service.self)
                    decodedServices.append(someService)
                }
            }
            
            self.decodedService = decodedServices
            print("Service codable")
            print(self.decodedService)
            decodedServices = []
        }
            
    }
}

struct SelectedCar_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectedCar(bottomSheetPosition: .middle, bottomSheetTranslation: 0, selectedCar:  Car(carName: "Mercedes-Benz", carModel: "S203", carImage: ["MB"], carMileage: 205000)    )
    }
}
