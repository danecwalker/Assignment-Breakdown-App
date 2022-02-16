//
//  DateView.swift
//  AssignmentTimeCalculator
//
//  Created by Dane Walker on 14/2/2022.
//

import SwiftUI
import EventKit

struct DateView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var assignmentName = ""
    @EnvironmentObject private var calModel : CalendarModel
    
    var body: some View {
        VStack {
            TextField("Assignment Name", text: $assignmentName)
                .padding(.vertical)
                .onChange(of: assignmentName) { newValue in
                    calModel.assignmentName = newValue
                }
            DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: [.date])
            DatePicker("Due Date", selection: $endDate, displayedComponents: [.date])
            Spacer()
            NavigationLink {
                BreakdownView(bd: calculateDates(startDate: startDate, endDate: endDate))
            } label: {
                Text("Calculate")
                    .foregroundColor(assignmentName.isEmpty ? Color(UIColor.systemBackground) : .primary)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(assignmentName.isEmpty ? Color.primary : .blue)
                    .cornerRadius(8)
            }
            .disabled(assignmentName.isEmpty)
            .animation(.easeOut, value: assignmentName.isEmpty)

        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationTitle("Assignment")
        .onAppear {
            calModel.reqAccess()
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView()
            .environmentObject(CalendarModel())
    }
}
