//
//  APYViewModel.swift
//  stablecoin
//
//  Created by minjoo kim on 6/30/24.
//

import Foundation
import Combine

class APYViewModel: ObservableObject {
    @Published var apyText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchAPY()
    }
    
    func fetchAPY() {
        guard let liveAPYURL = URL(string: "https://reverse-proxy-testing.up.railway.app/functions/v1/get-aave-live-yield"),
              let avgAPYURL = URL(string: "https://reverse-proxy-testing.up.railway.app/functions/v1/get-aave-30d-yield") else { return }
        
        let liveAPYPublisher = URLSession.shared.dataTaskPublisher(for: liveAPYURL)
            .map { $0.data }
            .decode(type: LiveAPYResponse.self, decoder: JSONDecoder())
            .map { $0.liveYield }
            .replaceError(with: 0.0)
        
        let avgAPYPublisher = URLSession.shared.dataTaskPublisher(for: avgAPYURL)
            .map { $0.data }
            .decode(type: AvgAPYResponse.self, decoder: JSONDecoder())
            .map { $0.avg30DYield }
            .replaceError(with: 0.0)
        
        Publishers.Zip(liveAPYPublisher, avgAPYPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] liveAPY, avgAPY in
                if liveAPY > avgAPY {
                    self?.apyText = String(format: "Live APY: %.2f%%", liveAPY*100)
                } else {
                    self?.apyText = String(format: "Avg APY this month: %.2f%%", avgAPY*100)
                }
            }
            .store(in: &cancellables)
    }
}

