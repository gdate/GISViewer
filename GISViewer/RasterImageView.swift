//
//  RasterImageView.swift
//  GISViewer
//
//  Created by teda on 2024/08/25.
//

import SwiftUI
import CoreLocation

struct RasterImageView: View {
    @State private var tileUrl: URL?
    @State private var tileCoordinates: (x: Int, y: Int)?
    
    @Binding var tileX: Int
    @Binding var tileY: Int
    
    let coordinate: CLLocationCoordinate2D
    let zoomLevel: Int
    
    var body: some View {
        VStack {
            if let url = makeURL(tileCoordinates: tileCoordinates ?? (0, 0), zoomLevel: zoomLevel) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .onChange(of: zoomLevel) { oldValue, newValue in
            tileCoordinates = calculateTileCoordinates(
                lat: coordinate.latitude,
                lon: coordinate.longitude,
                zoomLevel: newValue
            )
            tileX = tileCoordinates?.x ?? 0
            tileY = tileCoordinates?.y ?? 0
        }
    }
    
    private func makeURL(tileCoordinates: (x: Int, y: Int), zoomLevel: Int) -> URL? {
        let urlString = String(format: "https://cyberjapandata.gsi.go.jp/xyz/std/%d/%d/%d.png", zoomLevel, tileCoordinates.x, tileCoordinates.y)
        return URL(string: urlString)
    }
    
    private func calculateTileCoordinates(lat: Double, lon: Double, zoomLevel: Int) -> (x: Int, y: Int) {
        // 2 ^ z を計算
        let n = pow(2.0, Double(zoomLevel))

        // タイルのx座標を計算
        let x = Int(n * ((lon + 180.0) / 360.0))
        
        // タイルのy座標を計算
        let latRad = lat * .pi / 180.0
        let y = Int(n * (1.0 - (log(tan(latRad) + 1.0 / cos(latRad)) / .pi)) / 2.0)
        
        print("zoomLebel=\(zoomLevel), x=\(x), y=\(y)")

        return (x, y)
    }
    
    @MainActor
    func updateTileCoordinates(x: Int, y: Int) {
        tileX = x
        tileY = y
    }
}

#Preview {
    RasterImageView(
        tileX: .constant(0),
        tileY: .constant(0),
        coordinate: CLLocationCoordinate2D(latitude: 35.681236, longitude: 139.767125),
        zoomLevel: 0
    )
}
