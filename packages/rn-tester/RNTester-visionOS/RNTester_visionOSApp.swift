//
//  RNTester_visionOSApp.swift
//  RNTester-visionOS
//
//  Created by Gabriel Donadel on 29/06/23.
//  Copyright © 2023 Facebook. All rights reserved.
//

import SwiftUI

@main
struct RNTester_visionOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
