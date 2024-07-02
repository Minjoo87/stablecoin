//
//  HomeHeaderView.swift
//  stablecoin
//
//  Created by minjoo kim on 7/1/24.
//

import SwiftUI

struct HomeHeaderView: View {
    @ObservedObject var viewModel: BalanceViewModel
    let currentDate: Date
    let currentBalance: Double
    @Binding var isDragging: Bool
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("TOTAL BALANCE")
                    .foregroundColor(.gray)
                    .font(.caption)
                
                Text("$\(currentBalance, specifier: "%.2f")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                if isDragging {
                    Text("\(currentDate, formatter: dateFormatter)")
                        .foregroundColor(.gray)
                }else {
                    Text(balanceChangeText())
                        .foregroundColor(viewModel.balanceChangeColor())
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "person")
                    .padding()
                    .font(.title2)
                    .background(Circle().fill(Color.grayDarker))
                    .foregroundColor(.gray)
            }
        }
        
    }

    private func balanceChangeText() -> String {
        let pastBalance = viewModel.data[0].balance
        let balanceDifference = viewModel.calculatePriceDifference()
        let percentageChange = (balanceDifference / pastBalance) * 100
        
        let formattedChange = numberFormatter.string(from: NSNumber(value: abs(balanceDifference))) ?? ""

        let formattedPercentage = String(format: "%.2f%%", abs(percentageChange))
        
        let changeSign = balanceDifference >= 0 ? "▲" : "▼"
        return "\(changeSign)\(formattedChange) (\(formattedPercentage)) \(getSelectedTimeString())"
    }
    
    func getSelectedTimeString() -> String{
        
        switch viewModel.selectedTimeRange {
        case .oneMonth:
            return "Past 30 days"
        case .threeMonths:
            return "Past 3 months"
        case .sixMonths:
            return "Past 6 months"
        case .oneYear:
            return "Past year"
        case .all:
            return "All time"
        }
    }
    
}

#Preview {
    HomeHeaderView(viewModel: BalanceViewModel(), currentDate: Date(), currentBalance: 10000.0, isDragging: .constant(false))
}
