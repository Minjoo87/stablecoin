//
//  BalanceViewModel.swift
//  stablecoin
//
//  Created by minjoo kim on 6/29/24.
//

import Foundation
import SwiftUI

class BalanceViewModel: ObservableObject {
    @Published var fullData: [DataPoint] = generateData()
    @Published var data: [DataPoint] = []
    @Published var selectedDate: Date?
    @Published var selectedBalance: Double?
    @Published var selectedTimeRange: TimeRange = .oneMonth
    
    init() {
        filterData(for: selectedTimeRange)
    }
    
    func filterData(for range: TimeRange) {
        let calendar = Calendar.current
        let now = Date()
        let filteredData: [DataPoint]
        
        switch range {
        case .oneMonth:
            let startDate = calendar.date(byAdding: .month, value: -1, to: now)!
            filteredData = fullData.filter { $0.date >= startDate }
        case .threeMonths:
            let startDate = calendar.date(byAdding: .month, value: -3, to: now)!
            filteredData = fullData.filter { $0.date >= startDate }
        case .sixMonths:
            let startDate = calendar.date(byAdding: .month, value: -6, to: now)!
            filteredData = fullData.filter { $0.date >= startDate }
        case .oneYear:
            let startDate = calendar.date(byAdding: .year, value: -1, to: now)!
            filteredData = fullData.filter { $0.date >= startDate }
        case .all:
            filteredData = fullData
        }
        
        data = filteredData
        selectedDate = nil
        selectedBalance = nil
    }
    
    func handleDragGesture(value: CGFloat) {
        let xPosition = value / UIScreen.main.bounds.width * 300
        let index = Int(xPosition / 300 * CGFloat(data.count))
        if index >= 0 && index < data.count {
            self.selectedDate = data[index].date
            self.selectedBalance = data[index].balance
        }
    }
    
    func resetSelection() {
        self.selectedDate = Date()
        self.selectedBalance = data.last?.balance
    }
    
    func changeTimeRange(_ timeRange: TimeRange) {
        selectedTimeRange = timeRange
        filterData(for: timeRange)
    }
    
    func calculatePriceDifference() -> Double{
        let pastBalance = data[0].balance
        let priceDifference = data.last!.balance - pastBalance
        return priceDifference
    }
    
    
    func balanceChangeColor() -> Color {
        let balanceDifference = calculatePriceDifference()
        return balanceDifference >= 0 ? .green : .red
    }
}
