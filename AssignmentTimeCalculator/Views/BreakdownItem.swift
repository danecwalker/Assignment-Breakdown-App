//
//  BreakdownItem.swift
//  AssignmentTimeCalculator
//
//  Created by Dane Walker on 14/2/2022.
//

import SwiftUI

struct BreakdownItem: View {
    var step : Step
   
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 8) {
                Text(step.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: step.icon)
            }
            Text("by \(step.dueDateString)")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
                .frame(height: 4)
            
            Text(step.description)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct BreakdownItem_Previews: PreviewProvider {
    static var previews: some View {
        BreakdownItem(step : .init(title: "hi", description: "there", icon: "magnifyingglass", dueDate: Date()))
    }
}
