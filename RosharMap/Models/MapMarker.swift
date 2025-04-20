//
//  MapMarker.swift
//  RosharMap
//
//  Created by Connor Hehn on 4/15/25.
//
import SwiftUI

struct MapMarker: Identifiable {
    let id = UUID()
    let x: CGFloat
    let y: CGFloat
    let color: Color
    let icon: String // systemName for SF Symbol, or custom
}
