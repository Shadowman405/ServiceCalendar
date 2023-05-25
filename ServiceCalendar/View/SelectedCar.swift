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
    
    var selectedCar: Car
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                
                let imageOffset = screenHeight + 36
                
                ZStack {
                    LinearGradient(colors: [.blue ,.black], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        .opacity(0.8)
                    
                    PlusButton()
                    
                    VStack {
                        Text(selectedCar.carName)
                            .padding(25)
                            .offset(y: -bottomSheetTranslationProrated * imageOffset)
                        
                        
//                        WebImage(url: URL(string: selectedCar.carImage[0]))
//                            .resizable()
//                            .frame(height: 250)
//                            .cornerRadius(20)
//                            .padding()
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
                        
                        ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
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

struct SelectedCar_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectedCar(selectedCar: Car(carName: "Mercedes-Benz", carModel: "S203", carImage: ["MB"], carMileage: 205000))
    }
}
