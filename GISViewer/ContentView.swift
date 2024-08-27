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
            // タイルビュー
            RasterImageView(
                tileX: $tileX,
                tileY: $tileY,
                coordinate: initialCoordinate,
                zoomLevel: zoomLevel
            )
            
            // 現在のタイルの座標を表示
            Text("Tile X: \(tileX), Tile Y: \(tileY)")
                .font(.headline)
                .padding(.top, 10)
            
            // ズームボタン
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
            
            // 現在のズームレベルを表示
            Text("Zoom Level: \(zoomLevel)")
                            .font(.headline)
        }
    }
    
    private func zoomIn() {
        // 最大ズームレベルを設定 (例: 18)
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
