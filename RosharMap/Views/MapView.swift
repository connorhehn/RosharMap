//
//  MapView.swift
//  RosharMap
//
//  Created by Connor Hehn on 4/14/25.
//

import SwiftUI

struct MapView: View {
    @State private var zoomScale: CGFloat = 1.0
    @GestureState private var gestureScale: CGFloat = 1.0

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            Image("map_base")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(zoomScale * gestureScale)
                .frame(height: UIScreen.main.bounds.height) // fills screen vertically
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
