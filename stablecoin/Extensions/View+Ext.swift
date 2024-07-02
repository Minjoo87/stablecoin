//
//  View+Ext.swift
//  stablecoin
//
//  Created by minjoo kim on 7/1/24.
//

import SwiftUI

extension View {
    func pressAndDragProxyView(viewModel: BalanceViewModel, isDragging: Binding<Bool>) -> some View {
        return PressAndHorizontalDragGestureView(
            onBegan: { (value) in
                isDragging.wrappedValue = true
                viewModel.handleDragGesture(value: value.location.x)
            }, onChanged: { (value) in
                viewModel.handleDragGesture(value: value.location.x)
            }, onEnded: { _ in
                isDragging.wrappedValue = false
                viewModel.resetSelection()
            }
        )
    }
}
