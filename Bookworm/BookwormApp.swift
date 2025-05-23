//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Дарья Яцынюк on 23.04.2025.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
