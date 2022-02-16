//
//  CalModel.swift
//  AssignmentTimeCalculator
//
//  Created by Dane Walker on 14/2/2022.
//

import SwiftUI
import EventKit

struct CalendarEventModel : Hashable {
    let title : String
    let description : String
    let startDate : Date
    
}

struct CalendarEventGroupModel : Hashable {
    let calendar : EKCalendar
    let calendarEvents : [CalendarEventModel]
}

class CalendarModel : ObservableObject {
    var assignmentName = ""
    var store = EKEventStore()
    
    func reqAccess() {
        store.requestAccess(to: .event) { granted, error in
            print(granted)
        }
    }
    
    func getCalendars() -> [EKCalendar] {
        return store.calendars(for: .event)
    }
    
    func createEvent(event : CalendarEventModel, calendar: EKCalendar) -> EKEvent? {
        let ev = EKEvent(eventStore: store)
        ev.calendar = calendar
        ev.isAllDay = true
        ev.title = event.title
        ev.notes = event.description
        ev.startDate = event.startDate
        ev.endDate = event.startDate
        
        do {
            try store.save(ev, span: .thisEvent, commit: true)
            return ev
        } catch {
            print(ev)
            return nil
        }
    }
    
    func createEvents(events : CalendarEventGroupModel) -> Bool {
        
        
        var success : Int = 0
        
        for event in events.calendarEvents {
            let ev = EKEvent(eventStore: store)
            ev.calendar = events.calendar
            ev.isAllDay = true
            ev.title = event.title
            ev.notes = event.description
            ev.startDate = event.startDate
            ev.endDate = event.startDate
            
            do {
                try store.save(ev, span: .thisEvent, commit: true)
                success += 1
            } catch {
                continue
            }
        }
        
        if success == events.calendarEvents.count {
            return true
        }
        
        return false
    }
}
