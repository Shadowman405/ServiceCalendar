//
//  SelectedCar.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 11.04.23.
//

import SwiftUI
import BottomSheet
import SDWebImageSwiftUI

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
                        Text(selectedCar.carName)
                            .padding(25)
                            .offset(y: -bottomSheetTranslationProrated * imageOffset)
                        
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
                        
                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated,selectedCar: selectedCar)
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
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
//                        Text("Back")
//                            .foregroundColor(.black)
                        Image(systemName: "arrowshape.turn.up.backward.2")
                            .foregroundColor(.black)
                    }

                }
            })
        }
        .navigationBarHidden(true)
    }
}

class ServicesViewModel: ObservableObject {
    @Published var errorMesage = ""
    @Published var decodedService: [Service] = []
    var selectedCar: Car?
    
    init(selectedCar: Car?) {
        self.selectedCar = selectedCar
        print("Selected car\n\(selectedCar?.carName)")
       // fetchCars()
        fetchServicesArray()
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
              
              print("Data\n\(data)")
              
//              _ = data["uid"] as? String ?? ""
//              let carName = data["carMark"] as? String ?? ""
//              let carModel = data["carModel"] as? String ?? ""
//              let carMileage = data["carMilage"] as? String ?? ""
//              let carImage = data["carImage"] as? [String] ?? [""]
//
//              decodedService.append(contentsOf: [Car(carName: carName, carModel: carModel, carImage: carImage, carMileage: Int(carMileage) ?? 0)])
          }
          
//          self.decodedCar = decodedServices
//          decodedServices = []
        }
    }
}

struct SelectedCar_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectedCar(bottomSheetPosition: .middle, bottomSheetTranslation: 0, selectedCar:  Car(carName: "Mercedes-Benz", carModel: "S203", carImage: ["MB"], carMileage: 205000))
    }
}
