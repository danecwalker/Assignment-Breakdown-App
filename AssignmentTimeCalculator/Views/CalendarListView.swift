//
//  CalendarListView.swift
//  AssignmentTimeCalculator
//
//  Created by Dane Walker on 16/2/2022.
//

import SwiftUI
import EventKit

struct CalendarListView: View {
    
    @EnvironmentObject private var calModel : CalendarModel

    @State private var calendars : [EKCalendar] = []
    @State private var sources : [String] = []
    @Binding var calendar : EKCalendar
    
    var body: some View {
        List {
            ForEach(sources.sorted(), id: \.self) { source in
                Section {
                    ForEach(calendars.filter({ cal in
                        return cal.source.title == source
                    }).sorted {
                        $0.title < $1.title
                    }, id: \.self) { cal in
                        Button {
                            calendar = cal
                        } label: {
                            HStack {
                                Circle()
                                    .foregroundColor(Color(cal.cgColor))
                                    .frame(width: 8, height: 8)
                                Text("\(cal.title)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Image(systemName: "checkmark").opacity(cal == calendar ? 1 : 0)
                            }
                        }
                        .foregroundColor(.primary)

                    }
                } header: {
                    Text("\(source)")
                }

            }
        }
        .onAppear {
            calendars = calModel.getCalendars()
            
            sources = Array(Set(calendars.map({ cal in
                return cal.source.title
            })))
            
            if let _calendar = calendars.first {
                calendar = _calendar
            } else {
                calendar = .init(for: .event, eventStore: calModel.store)
                calendar.title = "Assignments"
                calendar.cgColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
                do {
                    try calModel.store.saveCalendar(calendar, commit: true)
                } catch {
                    print("error creating cal")
                }
            }
        }
        .navigationTitle("Calendars")
    }
}

struct CalendarListView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarListView(calendar: .constant(EKCalendar.init(for: .event, eventStore: CalendarModel().store)))
    }
}
