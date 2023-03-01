//
//  MoviesView.swift
//  MyFirstApp
//
//  Created by Philip Keller on 3/1/23.
//

import SwiftUI

struct MoviesView: View {
    
    @StateObject var viewModel = MoviesViewModel()
    
    var body: some View {
        List(viewModel.movies) { movie in
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
        .task {
            await viewModel.loadMovies()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
