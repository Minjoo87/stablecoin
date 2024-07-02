//
//  MiddleSectionView.swift
//  stablecoin
//
//  Created by minjoo kim on 7/1/24.
//

import SwiftUI

struct MiddleSectionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("● $10,000.00 • New Funds Available")
            Text("Tap below to earn 10.66% on your new funds →")
        }
        .foregroundColor(.white)
        .frame(width:UIScreen.main.bounds.width - 60, alignment: .leading)
        .padding()
        .background(Color.grayDark)
        .cornerRadius(10)
        
        
        
    }
}

#Preview {
    MiddleSectionView()
}

