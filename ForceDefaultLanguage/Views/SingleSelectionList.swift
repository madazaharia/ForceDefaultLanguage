//
//  SingleSelectionList.swift
//  ForceDefaultLanguage
//
//  Created by Madalin Zaharia on 11.01.2024.
//

import SwiftUI

public struct SingleSelectionList<Item: Identifiable, Content: View>: View {
    // MARK: - Properties
    let items: [Item]
    let rowContent: (Item) -> Content
    let action: (Item) -> Void

    public init(items: [Item], rowContent: @escaping (Item) -> Content, action: @escaping (Item) -> Void) {
        self.items = items
        self.rowContent = rowContent
        self.action = action
    }

    // MARK: - Drawing
    public var body: some View {
        ScrollView {
            ForEach(items) { item in
                rowContent(item)
                    .onTapGesture {
                        action(item)
                    }
            }
        }
    }
}
