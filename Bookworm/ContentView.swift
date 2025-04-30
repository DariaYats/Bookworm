//
//  ContentView.swift
//  Bookworm
//
//  Created by Дарья Яцынюк on 23.04.2025.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author),
        SortDescriptor(\Book.rating, order: .reverse)
    ]) var books: [Book]

    @State private var showingAddScreen = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .navigationDestination(for: Book.self) { book in
                    DetailView(book: book)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add book", systemImage: "plus") {
                            showingAddScreen.toggle()
                        }
                    }

                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
    }

    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]

            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
