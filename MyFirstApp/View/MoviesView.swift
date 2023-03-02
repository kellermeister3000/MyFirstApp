//
//  MoviesView.swift
//  MyFirstApp
//
//  Created by Philip Keller on 3/1/23.
//

import SwiftUI

struct MoviesView: View {
    
    @StateObject private var viewModel = MoviesViewModel()
    
    var body: some View {
        Group {
            
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error(let error):
                VStack {
                    Text(error.localizedDescription)
                    
                    Button("Retry?") {
                        Task {
                            await viewModel.loadMovies()
                        }
                    }
                }
            case .loaded(let movies):
                list(of: movies)
            }
        }
        .navigationTitle("Upcoming Movies")
        .task {
            await viewModel.loadMovies()
        }
    }
    
    @ViewBuilder
    func list(of movies: [Movie]) -> some View {
        if movies.isEmpty == false {
            List(movies) { movie in
                NavigationLink {
                    MovieDetailsView(movie: movie)
                } label: {
                    HStack {
                        AsyncImage(url: movie.posterURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80)
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                                .bold()
                            Text(movie .overview)
                                .lineLimit(4)
                        }
                    }
                    .padding()
                }
            }
        } else {
            Text("No upcoming movies")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoviesView()
        }
    }
}
