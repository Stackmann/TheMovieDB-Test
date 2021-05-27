//
//  MovieGridView.swift
//  TheMovieDB-Test
//
//  Created by admin on 26.05.2021.
//

import SwiftUI

struct MovieGridView: View {
    //@State var popularMovies = [MoviePop]()
    @StateObject var viewModel = Storage()
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(viewModel.popularMovies, id: \.id) { movie in
                        MovieTitleView(movie: movie)
                    }
                    Text("Load more...")
                        .onAppear { loadData() }
                }
                .padding()
                .onAppear { loadData() }
            }
            .navigationTitle("Popular movies")
        }
    }
    
    func loadData() {
        viewModel.loadPolular()
    }
    
    func loadImages() {
        
    }
}

struct MovieGridView_Previews: PreviewProvider {
    static var previews: some View {
        MovieGridView()
    }
}

struct MovieTitleView: View {
    let movie: MoviePop
    
    var body: some View {
        VStack(alignment: .leading){
            ImageFromURL(urlString: Constants.movieImagePath + movie.posterPath)
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
