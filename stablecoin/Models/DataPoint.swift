//
//  DataPoint.swift
//  stablecoin
//
//  Created by minjoo kim on 6/29/24.
//

import Foundation

struct DataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let balance: Double
}

enum TimeRange: String, CaseIterable {
    case oneMonth = "1M"
    case threeMonths = "3M"
    case sixMonths = "6M"
    case oneYear = "1Y"
    case all = "ALL"
}

func generateData() -> [DataPoint] {
    var data: [DataPoint] = []
    var balance: Double = 1000
    let calendar = Calendar.current
    
    for day in 0..<400 {
        if let date = calendar.date(byAdding: .day, value: day, to: Date().addingTimeInterval(-400*24*60*60)) {
            balance += Double.random(in: -10...10)
            data.append(DataPoint(date: date, balance: balance))
        }
    }
    return data
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
