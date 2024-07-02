//
//  EarningsInfoView.swift
//  stablecoin
//
//  Created by minjoo kim on 7/1/24.
//

import SwiftUI

struct EarningsInfoView: View {
    var body: some View {
        VStack {
            HStack() {
                Label("Unclaimed Earnings ", systemImage: "info.circle")
                    .labelStyle(.trailingIcon)
                Spacer()
                Text("$0.00")
            }
            
            HStack() {
                Text("Earnings Past 30 Days")
                Spacer()
                Text("+$10,000.00 (0.00%)")
            }
            .padding(.top, 5)
            
            HStack() {
                Text("Total Earnings")
                Spacer()
                Text("+$10,000.00 (0.00%)")
            }
            .padding(.top, 5)
        }
        .foregroundColor(.gray)
    }
}

#Preview {
    EarningsInfoView()
}

