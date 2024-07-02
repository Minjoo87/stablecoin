//
//  stablecoinApp.swift
//  stablecoin
//
//  Created by minjoo kim on 6/28/24.
//

import SwiftUI

@main
struct stablecoinApp: App {
    @StateObject var viewModel = APYViewModel()
    var body: some Scene {
        WindowGroup {
            OnboardingView(viewModel: viewModel)
        }
    }
}
