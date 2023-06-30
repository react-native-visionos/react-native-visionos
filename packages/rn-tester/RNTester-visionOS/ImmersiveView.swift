//
//  ImmersiveView.swift
//  RNTester-visionOS
//
//  Created by Gabriel Donadel on 29/06/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
