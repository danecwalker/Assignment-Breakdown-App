//
//  BreakdownView.swift
//  AssignmentTimeCalculator
//
//  Created by Dane Walker on 14/2/2022.
//

import SwiftUI
import EventKit

struct BreakdownView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var bd : Breakdown
    @EnvironmentObject private var calModel : CalendarModel
    
    @State private var calendar : EKCalendar = EKCalendar.init(for: .event, eventStore: CalendarModel().store)
    
    var body: some View {
        VStack {
            List {
                ForEach(bd.steps, id: \.self) { step in
                    BreakdownItem(step: step)
                        .padding(.vertical)
                }
            }
            
            NavigationLink(calendar.title.isEmpty ? "Choose Calendar" : calendar.title, destination: {
                CalendarListView(calendar: $calendar)
            })
                .padding([.top, .horizontal])
            

            
            Button {
                let events = bd.steps.map { step in
                    return CalendarEventModel(title: "\(calModel.assignmentName) - \(step.title)", description: step.description, startDate: step.dueDate)
                }
                
                let success = calModel.createEvents(events: CalendarEventGroupModel(calendar: calendar, calendarEvents: events))
                
                if success {
                    print("save")
                    presentationMode.wrappedValue.dismiss()
                }
                
            } label: {
                Text("Save")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle(bd.days)
    }
}

struct BreakdownView_Previews: PreviewProvider {
    static var previews: some View {
        BreakdownView(bd: .init(days: "2 days", steps: [.init(title: "hi", description: "there", icon: "magnifyingglass", dueDate: Date())]))
            .environmentObject(CalendarModel())
    }
}
