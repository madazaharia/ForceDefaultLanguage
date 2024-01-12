//
//  LanguageSelectionView.swift
//  ForceDefaultLanguage
//
//  Created by Madalin Zaharia on 11.01.2024.
//

import SwiftUI

struct LanguageSelectionView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: ViewModel
    let openSettingsURL = URL(string: UIApplication.openSettingsURLString)!

    // MARK: - Drawing
    var body: some View {
        SingleSelectionList(items: viewModel.items) { item in
            languageView(item: item)
        } action: { item in
            if item.type != viewModel.selectedItem?.type {
                UIApplication.shared.open(openSettingsURL)
            }
        }
        .padding(.horizontal, 16)
        .onAppear {
            viewModel.getItems()
            viewModel.getCurrentLanguage()
        }
    }
    
    @ViewBuilder
    func languageView(item: LanguageItem) -> some View {
        HStack {
            Text(item.title)

            Spacer()

            if item.id == viewModel.selectedItem?.id {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .background(Color.gray.opacity(0.3))
    }
}

extension LanguageSelectionView {
    struct LanguageItem: Identifiable, Equatable {
        var id = UUID().uuidString
        var title: String
        var type: String
    }
}

#Preview {
    LanguageSelectionView(viewModel: .init(localStorage: LocalStorage()))
}
