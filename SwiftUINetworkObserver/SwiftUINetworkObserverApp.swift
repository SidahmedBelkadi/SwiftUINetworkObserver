//
//  SwiftUINetworkObserverApp.swift
//  SwiftUINetworkObserver
//
//  Created by Sidahmed BELKADI on 06/09/2025.
//

import SwiftUI

@main
struct SwiftUINetworkObserverApp: App {
    
    @StateObject private var networkMonitor = NetworkMonitor()
        
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.isNetworkConnected, networkMonitor.isConnected)
                .environment(\.connectionTye, networkMonitor.connectionType)
        }
    }
}
