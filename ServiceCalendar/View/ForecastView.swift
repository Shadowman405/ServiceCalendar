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
    var selectedCar: Car?
    
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
    
    var someCar: Car
    
    init(someCar: Car) {
        self.someCar = someCar
       // fetchCarsArrayNested()
    }
    
    func fetchCarsArray() {
        self.decodedService = []
        var decodedService: [Service] = []
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("cars").document("\(uid)\(someCar.carName)\(someCar.carModel)").addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            let doc = snapshot!.reference
          for eachDoc in doc {
              let data = eachDoc.data()
              
              _ = data["uid"] as? String ?? ""
              let carName = data["carMark"] as? String ?? ""
              let carModel = data["carModel"] as? String ?? ""
              let carMileage = data["carMilage"] as? String ?? ""
              let carImage = data["carImage"] as? [String] ?? [""]
              
              decodedService.append(contentsOf: [Car(carName: carName, carModel: carModel, carImage: carImage, carMileage: Int(carMileage) ?? 0)])
          }
          
          self.decodedService = decodedService
          decodedService = []
        }
    }

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(selectedCar: Car(carName: "Mercedes-Benz", carModel: "S203", carImage: ["MB"], carMileage: 205000))
    }
}
