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
                    Image("movie1-medium")
                        .resizable()
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(viewModel.movie.name)
                            //.padding(.bottom, -100)
                            .padding(.leading, 10)
                            //.offset(y: -100)
                            .foregroundColor(.white)
                            .font(.title)
                        Text("★★★")
                            //.padding(.bottom, -60)
                            .padding(.leading, 10)
                            //.offset(y: -60)
                            .foregroundColor(.white)
                            .font(.body)
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
                            Text("★★★")
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
            .padding(EdgeInsets(top: 0, leading: 0, bottom: -65, trailing: 10))
            .offset(y: -65)
//            ZStack {
                //Color(.white)
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Release date")
                                .font(.title3)
                            Spacer()
                            Text("01.12.2019")
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Genre")
                                .font(.title3)
                            Spacer()
                            Text("Romantic")
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Language")
                                .font(.title3)
                            Spacer()
                            Text("English")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Overview")
                        .padding(.leading, 10)
                        .foregroundColor(.primary)
                    Text("Bohemian Rhapsody is a foot-stomping celebration of Queen, their music and their extraordinary lead singer Freddie Mercury. Freddie defied stereotypes and shattered convention to become one of the most beloved entertainers on the planet. The film traces the meteoric rise of the band through their iconic songs and revolutionary sound. They reach unparalleled success, but in an unexpected turn Freddie, surrounded by darker influences, shuns Queen in pursuit of his solo career. Having suffered greatly without the collaboration of Queen, Freddie manages to reunite with his bandmates just in time for Live Aid. While bravely facing a recent AIDS diagnosis, Freddie leads the band in one of the greatest performances in the history of rock music. Queen cements a legacy that continues to inspire outsiders, dreamers and music lovers to this day.")
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .foregroundColor(.secondary)
                        .frame(width: 375, height: 100)
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
//            }
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
