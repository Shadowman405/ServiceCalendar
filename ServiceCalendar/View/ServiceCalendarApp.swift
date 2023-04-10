//
//  ServiceCalendarApp.swift
//  ServiceCalendar
//
//  Created by Maxim Mitin on 5.04.23.
//

import SwiftUI
import Firebase

@main
struct ServiceCalendarApp: App {
    
//    @StateObject private var carsGrid = CarGrid()
//    @State var select = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
               // .environmentObject(carsGrid)
        }
    }
}
