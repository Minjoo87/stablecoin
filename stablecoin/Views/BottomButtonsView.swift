//
//  BottomButtonsView.swift
//  stablecoin
//
//  Created by minjoo kim on 7/1/24.
//

import SwiftUI

struct BottomButton: View {
    let title: String
    let systemImage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.grayDark)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct BottomButtonsView: View {
    var body: some View {
        HStack {
            BottomButton(title: "Deposit", systemImage: "arrow.down.left") {
            }
            
            BottomButton(title: "Withdraw", systemImage: "arrow.up.right") {
            }
        }
    }
}

#Preview {
    BottomButtonsView()
}
