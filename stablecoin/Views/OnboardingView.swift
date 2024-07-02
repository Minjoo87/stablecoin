//
//  OnboardingView.swift
//  stablecoin
//
//  Created by minjoo kim on 6/30/24.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: APYViewModel
    @State private var isNavigateToHome = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("StableWorkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 50)
                
                Image("OnboardingScreenShot")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .padding(.top, 50)
                
                if viewModel.apyText.isEmpty {
                    ProgressView()
                        .padding(.top, 20)
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    HStack() {
                        Text("●")
                            .foregroundColor(.green)
                        Text(viewModel.apyText)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding(7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .padding(.top, 20)
                }
                
                
                Text("Earn high yield on your funds, \npowered by stablecoins")
                    .font(.headline)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                
                Spacer()
                
                NavigationLink(destination: HomeView(), isActive: $isNavigateToHome) {
                    Text("Create Account")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Text("or Sign In to Existing Account")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
            .padding(.top, 50)
            .background(Color.black)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


#Preview {
    OnboardingView(viewModel: APYViewModel())
}
