//
//  MovieDetailView.swift
//  TheMovieDB-Test
//
//  Created by admin on 25.05.2021.
//

import SwiftUI

struct MovieDetailView: View {
//    var moviePop: MoviePop
//    @State private var movie: Movie
    @ObservedObject var viewModel: StorageMovie
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                if viewModel.state == .hasBeenLoaded {
                    ImageFromURL(urlString: Constants.movieImagePath + (viewModel.movie.posterName ?? ""))
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(viewModel.movie.name)
                                //.padding(.bottom, -100)
                                .padding(.leading, 10)
                                //.offset(y: -100)
                                .foregroundColor(.white)
                                .font(.title)
                            Text(viewModel.movie.rate)
                                //.padding(.bottom, -60)
                                .padding(.leading, 10)
                                //.offset(y: -60)
                                .foregroundColor(.white)
                                .font(.body)
                        }
                        Spacer()
                    }
                } else {
                    Image("empty")
                        .resizable()
                        //.frame(width: 400, height: 300)
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Text("Error loading")
                                .padding(.leading, 10)
                                //.offset(y: -100)
                                .foregroundColor(.red)
                                .font(.title)
                            Text("★")
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
                                //.offset(y: -60)
                                .foregroundColor(.white)
                                .font(.body)
                        }
                        Spacer()
                    }
                }
            }
            HStack {
                Spacer()
                Image("play button orange")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: -50, trailing: 10))
            .offset(y: -50)
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        if viewModel.state == .hasBeenLoaded {
                            VStack(alignment: .leading) {
                                Text("Release date")
                                    .font(.title3)
                                Spacer()
                                Text(viewModel.movie.releaseDate)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Genre")
                                    .font(.title3)
                                Spacer()
                                Text(viewModel.movie.genres[0].name)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Language")
                                    .font(.title3)
                                Spacer()
                                Text(viewModel.movie.language)
                                    .foregroundColor(.secondary)
                            }
                        } else {
                            VStack(alignment: .leading) {
                                Text("Release date")
                                    .font(.title3)
                                Spacer()
                                Text("--")
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Genre")
                                    .font(.title3)
                                Spacer()
                                Text("--")
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Language")
                                    .font(.title3)
                                Spacer()
                                Text("--")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Overview")
                        .padding(.leading, 10)
                        .foregroundColor(.primary)
                    if viewModel.state == .hasBeenLoaded {
                        Text(viewModel.movie.overview ?? "---")
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .foregroundColor(.secondary)
                            .frame(width: 375, height: 100)
                    } else {
                        Text("---")
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .foregroundColor(.secondary)
                            .frame(width: 375, height: 100)
                    }
                    HStack {
                        Spacer()
                        Text("Read more")
                            .padding(.trailing, 10)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    Text("Main cast")
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))

                        .foregroundColor(.primary)
                    ScrollView(.horizontal) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Tomb Raider")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Image("actor1")
                                    .resizable()
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .frame(width: 60, height: 60)
                                Text("Angelina Jolie")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Genre")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Image("actor1")
                                    .resizable()
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .frame(width: 60, height: 60)
                                Text("Romantic")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Language")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Image("actor1")
                                    .resizable()
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .frame(width: 60, height: 60)
                                Text("English")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        Text("Home page")
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .onAppear { viewModel.loadMovie()}
        .ignoresSafeArea(edges: .all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: StorageMovie(with: MoviePop(id: UUID(), idMovie: 0, name: "name", voteAverage: 3, posterPath: "", genreIds: [], overview: "")))
    }
}
