//
//  ContentView.swift
//  AssignmentTimeCalculator
//
//  Created by Dane Walker on 14/2/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var calModel : CalendarModel = CalendarModel()
    
    var body: some View {
        NavigationView {
            DateView()
        }
        .environmentObject(calModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
