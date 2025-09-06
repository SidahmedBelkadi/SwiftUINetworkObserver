//
//  ContentView.swift
//  SwiftUINetworkObserver
//
//  Created by Sidahmed BELKADI on 06/09/2025.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.isNetworkConnected) private var isConnected
    @Environment(\.connectionTye) private var connectionType
    
    var body: some View {
        NavigationStack {
            List {
                Section("Status") {
                    Text((isConnected ?? false) ? "Connected" : "No Internet")
                }
                
                if let connectionType {
                    Section("Type") {
                        Text(String(describing: connectionType).capitalized)
                    }
                }
            }
            .navigationTitle("Network Monitor")
        }
        .sheet(isPresented: .constant(!(isConnected ?? true))) {
            NoInternetView()
                .presentationDetents([.height(310)])
                .presentationCornerRadius(0)
                .presentationBackgroundInteraction(.disabled)
                .presentationBackground(.clear)
                .interactiveDismissDisabled()
        }
    }
}

#Preview {
    ContentView()
}


struct NoInternetView: View {
    
    @Environment(\.isNetworkConnected) private var isConnected
    @Environment(\.connectionTye) private var connectionType
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: connectionType == .wifi ? "wifi.exclamationmark" : "antenna.radiowaves.left.and.right.slash")
                .font(.system(size: 89, weight: .semibold ))
                .frame(height: 80)
            
            Text("No Internet Connectivity")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("Please check your internet connection\nto continue using the app.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
                .lineLimit(2)
            
            Text("Waiting for internet connection...")
                .font(.caption)
                .foregroundStyle(.background)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color.primary)
                .padding(.top, 10)
                .padding(.horizontal, -20)
        }
        .fontDesign(.rounded)
        .padding([.horizontal, .top], 20)
        .background(.background)
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
        .frame(height: 310)
    }
}
