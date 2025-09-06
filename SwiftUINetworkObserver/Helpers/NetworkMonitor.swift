//
//  NetworkMonitor.swift
//  SwiftUINetworkObserver
//
//  Created by Sidahmed BELKADI on 06/09/2025.
//

import Foundation
import Network
import SwiftUICore

extension EnvironmentValues {
    @Entry var isNetworkConnected: Bool?
    @Entry var connectionTye: NWInterface.InterfaceType?
}


class NetworkMonitor: ObservableObject {
    @Published var isConnected: Bool?
    @Published var connectionType: NWInterface.InterfaceType?
    
    // Monitor properties
    private var queue = DispatchQueue(label: "Monitor")
    private var monitor = NWPathMonitor()
    
    init() {
        startMonitoring()
    }
    
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            Task { @MainActor in
                self.isConnected = path.status == .satisfied
                
                let types: [NWInterface.InterfaceType] = [.wifi, .cellular, .loopback]
                if let type = types.first(where: { path.usesInterfaceType($0) }) {
                    self.connectionType = type
                } else {
                    self.connectionType = nil
                }
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
}


