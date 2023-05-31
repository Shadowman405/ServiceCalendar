//
//  ForecastView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 12.04.23.
//

import SwiftUI

struct ForecastView: View {
    var bottomSheetTranslationProrated: CGFloat = 1
    @State private var selection = 0
    @ObservedObject var vm: ServicesViewModel
    var selectedCar: Car?
    
    init(bottomSheetTranslationProrated:CGFloat?, selectedCar: Car?){
        self.bottomSheetTranslationProrated = bottomSheetTranslationProrated ?? 1
        self.selectedCar = selectedCar
        self.vm = .init(selectedCar: selectedCar)
    }
    
    
    var body: some View {
        
        ScrollView {
            VStack() {
                SegmentedControl(selection: $selection)
                
                //MARK: - Service Cards
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 12) {
                        if selection == 0 {
                            HStack {
                                ForEach(ServiceSegmentedControlModel.mockService) { service in
    //                                ForecastCard(service: service, segmentedControlChoice: .service)
                                    NavigationLink(destination: ServiceDetailView(selectedService: service)) {
                                        ForecastCard(service: service, segmentedControlChoice: .service)
                                    }
                                }
                                .transition(.offset(x: -430))
                                
                                NavigationLink(destination: AddNewServiceView(selectedCar: selectedCar)) {
                                    PlusButton()
                                }
                            }
                        } else {
                            HStack {
                                ForEach(ServiceSegmentedControlModel.mockService) { service in
                                    ForecastCardMoney(service: service, segmentedControlChoice: .service)
                                }
                                .transition(.offset(x: 430))
                                
                                NavigationLink(destination: AddNewServiceView(selectedCar: selectedCar)) {
                                    PlusButton()
                                }
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 5)
            }
            
        }
        .backgroundBlur(radius: 25,opaque: true)
        .background(Gradient(colors: [Color.purple, Color.blue]))
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44), color: Color.bottomSheetBorderMiddle,lineWidth: 1,offsetX: 0,offsetY: 1,blur: 0,blendMode: .overlay,opacity: 1 - bottomSheetTranslationProrated)
        .overlay {
            Divider()
                .blendMode(.overlay)
                .background(Color.black)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        }
        .overlay {
            //MARK: - Drag Indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .opacity(0.3)
                .frame(width: 48,height: 5)
                .frame(height:20)
                .frame(maxHeight: .infinity, alignment: .top)
        }
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

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(bottomSheetTranslationProrated: 1, selectedCar: Car(carName: "Mercedes-Benz", carModel: "S203", carImage: ["MB"], carMileage: 205000))
    }
}
