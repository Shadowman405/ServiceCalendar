//
//  CarEditView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 1.07.23.
//

import SwiftUI
import PhotosUI

struct CarEditView: View {
    var selectedCar: Car
    @Environment(\.dismiss) var dismiss
    @State private var carMark : String = ""
    @State private var carModel : String = ""
    @State private var carMileage : String = ""
    @State private var carPhoto: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @State var imagesArray : [String] = []
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CarEditView_Previews: PreviewProvider {
    static var previews: some View {
        CarEditView(selectedCar: FireBaseHelper().mockCar)
    }
}
