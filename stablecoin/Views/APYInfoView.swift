//
//  APYInfoView.swift
//  stablecoin
//
//  Created by minjoo kim on 7/2/24.
//

import SwiftUI

struct APYInfoView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Live APY")
                HStack {
                    Text("●")
                        .foregroundColor(.green)
                    Text("10.93%")
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Avg APY last 30d")
                Text("10.67%")
            }
            .padding(.leading, -(UIScreen.main.bounds.width / 2) + 20)
        }
        .foregroundColor(.gray)
    }
}

#Preview {
    APYInfoView()
}
