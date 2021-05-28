//
//  HomeView.swift
//  TheMovieDB-Test
//
//  Created by admin on 28.05.2021.
//

import SwiftUI

struct HomeView: View {
    @State private var hasBeenLoggedIn: Bool = false
    
    var body: some View {
        
        if hasBeenLoggedIn {
            MovieGridView()
        } else {
            YourLoginView(hasBeenLoggedIn: $hasBeenLoggedIn)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct YourLoginView: View {
    @Binding var hasBeenLoggedIn: Bool

    var body: some View {
        Button(action: { hasBeenLoggedIn = true }) { Text("Login") }
    }
}
