//
//  TimeRangeView.swift
//  stablecoin
//
//  Created by minjoo kim on 7/1/24.
//

import SwiftUI

struct TimeRangeButton: View {
    let range: TimeRange
    let currentTimeRange: TimeRange
    let currentColor: Color
    let action: () -> Void
    
    
    var body: some View {
        Button(action: action) {
            Text(range.rawValue)
                .padding(.vertical, 6)
                .padding(.horizontal, 15)
                .background(range == currentTimeRange ? currentColor : Color.clear)
                .foregroundColor(range == currentTimeRange ? .black : .white)
                .cornerRadius(5)
        }
    }
}

struct TimeRangeView: View {
    @ObservedObject var viewModel: BalanceViewModel
    
    let currentTimeRange: TimeRange
    var selectedTimeRange: (_ timeRange: TimeRange) -> Void
    
    var body: some View {
        HStack(spacing: 0.0) {
            ForEach(TimeRange.allCases, id: \.self) { range in
                TimeRangeButton(range: range, currentTimeRange: currentTimeRange, currentColor: viewModel.balanceChangeColor()) {
                    selectedTimeRange(range)
                }
                if range != TimeRange.allCases.last {
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(6)
        .background(Color.grayDark)
        .cornerRadius(5)
    }
}

#Preview {
    let viewModel = BalanceViewModel()
    return TimeRangeView(viewModel: viewModel, currentTimeRange: viewModel.selectedTimeRange,
                         selectedTimeRange: viewModel.changeTimeRange)
}
