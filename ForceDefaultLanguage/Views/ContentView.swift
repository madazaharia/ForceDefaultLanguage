//
//  ContentView.swift
//  ForceDefaultLanguage
//
//  Created by Madalin Zaharia on 11.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    let localStorage: LocalStorage
    @State private var showSettingsView = false
    
    var body: some View {
        NavigationView {
            NavigationLink(
                destination: LanguageSelectionView(viewModel: .init(localStorage: localStorage)),
                isActive: $showSettingsView,
                label: {
                    settingsButton
                }
            )
        }
    }
    
    private var settingsButton: some View {
        Button {
            showSettingsView = true
        } label: {
            Text("settings".localized)
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
        .padding(8)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color(.blue), lineWidth: 1)
        )
    }
}

#Preview {
    ContentView(localStorage: LocalStorage())
}
