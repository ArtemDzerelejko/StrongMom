//
//  ContentView.swift
//  StrongMom
//
//  Created by artem on 16.01.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.custom("Montserrat-Regular", size: 17))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
