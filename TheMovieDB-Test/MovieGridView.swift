//
//  MovieGridView.swift
//  TheMovieDB-Test
//
//  Created by admin on 26.05.2021.
//

import SwiftUI

struct MovieGridView: View {
    @State var popularMovies: [Movie]
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(popularMovies, id: \.id) { movie in
                        MovieTitleView(movie: movie)
                    }
                }
                .padding()
                .onAppear {
                    
                }
            }
            .navigationTitle("Popular movies")
        }
    }
}

struct MovieGridView_Previews: PreviewProvider {
    static var previews: some View {
        MovieGridView(popularMovies: [])
    }
}

struct MovieTitleView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading){
            movie.posterImage
                .resizable()
                .frame(width: 170, height: 170)
                .cornerRadius(20)
            Text(movie.name)
                .offset(y: -15)
                .padding(.top, -15)
                .padding(.leading, 10)
                .foregroundColor(.white)
                .scaledToFit()
                .minimumScaleFactor(0.6)
        }
    }
}
