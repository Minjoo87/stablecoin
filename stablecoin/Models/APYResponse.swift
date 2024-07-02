//
//  APYResponse.swift
//  stablecoin
//
//  Created by minjoo kim on 6/30/24.
//

import Foundation

struct LiveAPYResponse: Decodable {
    let liveYield: Double
}


struct AvgAPYResponse: Decodable {
    let avg30DYield: Double
}

