//
//  AddNewServiceView.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 26.05.23.
//

import SwiftUI

struct AddNewServiceView: View {
    @State private var mileage = 0
    @State private var date = Date()
    @State private var isDone = false
    @State private var checkMoney = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddNewServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewServiceView()
    }
}
