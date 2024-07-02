//
//  HomeView.swift
//  stablecoin
//
//  Created by minjoo kim on 6/29/24.
//

import SwiftUI
import Charts

struct HomeView: View {
    @StateObject private var viewModel = BalanceViewModel()
    @State var isDragging: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                HomeHeaderView(viewModel: viewModel, 
                               currentDate: viewModel.selectedDate != nil ? viewModel.selectedDate! : viewModel.data.last!.date,
                               currentBalance: viewModel.selectedBalance ?? viewModel.data.last?.balance ?? 0,
                               isDragging: $isDragging)
                .padding([.leading, .trailing])
                
                ChartView(viewModel: viewModel)
                    .overlay(pressAndDragProxyView(viewModel: viewModel, isDragging: $isDragging))
                
                TimeRangeView(viewModel: viewModel,
                              currentTimeRange: viewModel.selectedTimeRange,
                              selectedTimeRange: viewModel.changeTimeRange)
                .padding([.leading, .trailing])
                .padding(.top, -15)
                
                MiddleSectionView()
                    .padding(.top)
                
                APYInfoView()
                    .padding([.top, .leading, .trailing])
                
                EarningsInfoView()
                    .padding([.top, .leading, .trailing])
                
                BottomButtonsView()
                    .padding(.top)
                    .padding([.leading, .trailing])
            }
        }
        .background(Color.black)
    }
    
    
}

#Preview {
    HomeView()
}
