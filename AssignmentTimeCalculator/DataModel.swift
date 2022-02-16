//
//  DataModel.swift
//  AssignmentTimeCalculator
//
//  Created by Dane Walker on 14/2/2022.
//

import SwiftUI

struct Breakdown : Hashable {
    let days : String
    let steps : [Step]
}

struct Step : Hashable, Identifiable {
    let id = UUID()
    let title : String
    let description : String
    let icon : String
    let dueDate : Date
    var dueDateString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMM yyyy"
        return dateFormatter.string(from: dueDate)
    }
}


func calculateDates(startDate : Date, endDate : Date) -> Breakdown {
    var steps : [Step] = []
    
    let g = ceil(trunc(DateInterval(start: startDate, end: endDate).duration).s2d)
    
    let a = startDate.advanced(by: trunc(g*0.05).d2s)
    let b = startDate.advanced(by: trunc(g*0.25).d2s)
    let c = startDate.advanced(by: trunc(g*0.35).d2s)
    let d = startDate.advanced(by: trunc(g*0.7).d2s)
    let e = startDate.advanced(by: trunc(g*0.9).d2s)
    let f = startDate.advanced(by: trunc(g*1).d2s)
    
    steps.append(.init(title: "Step 1: Analyse your task", description: "\u{2022} Analyse the task.\n\u{2022} Make sure you work out what you need to research and how to structure your assignment.", icon: "chart.pie", dueDate: a))
    
    steps.append(.init(title: "Step 2: Find your information", description: "\u{2022} Read broader general resources (textbooks) before resources on specific topics (journal articles).", icon: "magnifyingglass", dueDate: b))
    
    steps.append(.init(title: "Step 3: Organise your notes", description: "\u{2022} Develop a plan according to the task words in your assignment.", icon: "book", dueDate: c))
    
    steps.append(.init(title: "Step 4: Write your draft", description: "\u{2022} For multipart assignments follow the order of the assignment as it is laid out in your task sheet. Each part is like a mini assignment.\n\u{2022} Don't forget to cite and reference your sources.", icon: "pencil", dueDate: d))
    
    steps.append(.init(title: "Step 5: Edit and proofread", description: "\u{2022} Revise your assignment.\n\u{2022} Make sure you have specifically responded to the task.\n\u{2022} Have done everything in the checklist you made in \"Analysing the task\", back in Step 1?", icon: "square.and.pencil", dueDate: e))
    
    steps.append(.init(title: "Step 6: Format your assignment", description: "\u{2022} Follow the formatting guidelines required by your lecturer.", icon: "paintbrush", dueDate: f))
    
    let breakdown : Breakdown = .init(days: "\(Int(g)) days", steps: steps)
    
    return breakdown
}

extension Double {
    var s2d : Double {
        self / 60 / 60 / 24
    }
    
    var d2s : Double {
        self * 60 * 60 * 24
    }
}
