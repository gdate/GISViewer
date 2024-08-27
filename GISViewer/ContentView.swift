//
//  ContentView.swift
//  GISViewer
//
//  Created by teda on 2024/08/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var zoomLevel: Int = 0
    @State private var tileX: Int = 0
    @State private var tileY: Int = 0
    
    // 東京駅の座標
    let initialCoordinate = CLLocationCoordinate2D(latitude: 35.681236, longitude: 139.767125)
    
    var body: some View {
        VStack {
            RasterImageView(
                tileX: $tileX,
                tileY: $tileY,
                coordinate: initialCoordinate,
                zoomLevel: zoomLevel
            )
            
            Text("Zoom Level: \(zoomLevel), Tile X: \(tileX), Tile Y: \(tileY)")
                .font(.headline)
                .padding(.top, 10)
            
            HStack {
                Button(action: {
                    zoomOut()
                }) {
                    Image(systemName: "minus.circle")
                        .font(.largeTitle)
                }
                
                Button(action: {
                    zoomIn()
                }) {
                    Image(systemName: "plus.circle")
                        .font(.largeTitle)
                }
            }
            .padding()
        }
    }
    
    private func zoomIn() {
        guard zoomLevel < 18 else { return }
        zoomLevel += 1
    }
    
    private func zoomOut() {
        guard zoomLevel >= 1 else { return }
        zoomLevel -= 1
    }
}

#Preview {
    ContentView()
}
