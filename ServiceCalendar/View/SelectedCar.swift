//
//  SelectedCar.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 11.04.23.
//

import SwiftUI
import BottomSheet

enum BotomSheetPosition: CGFloat, CaseIterable {
    case top = 0.82
    case middle = 0.385
}

struct SelectedCar: View {
    @State var bottomSheetPosition: BotomSheetPosition = .middle
    @State var bottomSheetChange = false
    @State var bottomSheetTranslation: CGFloat = BotomSheetPosition.middle.rawValue
    
    var selectedCar: Car
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                
                ZStack {
                    LinearGradient(colors: [.blue ,.black], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        .opacity(0.8)
                    
                    VStack {
                        Text(selectedCar.carName)
                            .padding(25)
                        
                        Image(selectedCar.carImage)
                            .resizable()
                            .frame(height: 250)
                            .cornerRadius(20)
                            .padding()
                        
                        Spacer()
                    }
                    
                    
                    BottomSheetView(position: $bottomSheetPosition) {
                        Text(bottomSheetTranslation.formatted())
                        
                    } content: {
                        ForecastView()
                    }
                    .onBottomSheetDrag { translation in
                        bottomSheetTranslation = translation / screenHeight
                    }

                    
                    TabBar(action: {
                        bottomSheetChange.toggle()
                        //bottomSheetPosition = .top
                        if bottomSheetChange {
                            bottomSheetPosition = .top
                        } else {
                            bottomSheetPosition = .middle
                        }
                    })
                }
            }
        }
        //.navigationBarHidden(true)
    }
}

struct SelectedCar_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectedCar(selectedCar: Car(id: 0, carName: "Mercedes-Benz", carImage: "MB", carMileage: 205000))
    }
}
