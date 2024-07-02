//
//  ChartView.swift
//  stablecoin
//
//  Created by minjoo kim on 7/1/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject var viewModel: BalanceViewModel
    
    var body: some View {
        Chart {
            ForEach(viewModel.data) { point in
                LineMark(
                    x: .value("Date", point.date),
                    y: .value("Balance", point.balance)
                )
                .interpolationMethod(.monotone)
                .foregroundStyle(Color.white)
                
                if let selectedDate = viewModel.selectedDate, point.date == selectedDate {
                    PointMark(
                        x: .value("Selected Date", selectedDate),
                        y: .value("Selected Balance", viewModel.selectedBalance ?? point.balance)
                    )
                    .foregroundStyle(viewModel.balanceChangeColor())
                    .symbolSize(40)
                    
                    RuleMark(x: .value("Selected Date", selectedDate))
                        .foregroundStyle(viewModel.balanceChangeColor())
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                }
            }
        }
        .chartYAxis(.hidden)
        .chartXAxis(.hidden)
        .chartXScale(domain: viewModel.data.first!.date...viewModel.data.last!.date)
        .chartYScale(domain: (viewModel.data.map { $0.balance }.min() ?? 0) - 10 ... (viewModel.data.map { $0.balance }.max() ?? 0) + 10)
        .frame(height: 300)
        .contentShape(Rectangle())
        .background(
            LinearGradient(gradient: Gradient(stops: [
                .init(color: .clear, location: 0.4),
                .init(color: viewModel.balanceChangeColor(), location: 0.9),
                .init(color: .clear, location: 1.0)
            ]),
            startPoint: .top,
            endPoint: .bottom)
            .opacity(0.1)
        )
    }
}

#Preview {
    ChartView(viewModel: BalanceViewModel())
}
