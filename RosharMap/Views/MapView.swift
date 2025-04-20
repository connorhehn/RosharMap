//
//  MapView.swift
//  RosharMap
//
//  Created by Connor Hehn on 4/14/25.
//

//import SwiftUI
//
//struct MapView: View {
//    @State private var zoomScale: CGFloat = 1.0
//    @GestureState private var gestureScale: CGFloat = 1.0
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: true) {
//            Image("map_base")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .scaleEffect(zoomScale * gestureScale)
//                .frame(height: UIScreen.main.bounds.height) // fills screen vertically
//                .gesture(
//                    MagnificationGesture()
//                        .updating($gestureScale) { value, state, _ in
//                            state = value
//                        }
//                        .onEnded { value in
//                            zoomScale *= value
//                        }
//                )
//        }
//        .background(Color.black)
//        .edgesIgnoringSafeArea(.all)
//    }
//}

import SwiftUI

struct MapView: View {
    @State private var zoomScale: CGFloat = 1.0
    @GestureState private var gestureScale: CGFloat = 1.0
    
    @State private var markers: [MapMarker] = []

    init() {
        let xScale = 1503.28 / 1720
        let yScale = 874.0 / 1000
        let x = xScale * 1423
        let y = yScale * (1000 - 259.5) // flip Y

        // Note: can't use @State here directly, so assigning in a var and using in init
        _markers = State(initialValue: [
            MapMarker(x: x, y: y, color: Color(red: 0.55, green: 0.71, blue: 0.95), icon: "star.fill")
        ])
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            ZStack(alignment: .topLeading) {
                Image("map_base")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(zoomScale * gestureScale)
                    .frame(height: UIScreen.main.bounds.height)
                    .overlay(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    print("Rendered image size: \(geo.size.width) x \(geo.size.height)")
                                }
                        }
                    )

                ForEach(markers) { marker in
                    Circle()
                        .fill(marker.color)
                        .frame(width: 36, height: 36)
                        .overlay(
                            Image(systemName: marker.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        )
                        .position(x: marker.x * zoomScale * gestureScale, y: marker.y * zoomScale * gestureScale)
                }
            }
            .gesture(
                MagnificationGesture()
                    .updating($gestureScale) { value, state, _ in
                        state = value
                    }
                    .onEnded { value in
                        zoomScale *= value
                    }
            )
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}
