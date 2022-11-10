//
//  PopularView.swift
//  EViOS5
//
//  Created by Mavrik on 10/11/2022.
//

import SwiftUI

struct PopularView: View {
	@EnvironmentObject var viewModel: PopularViewModel
	
	var body: some View {
		NavigationView {
			VStack {
				Text("Popular")
					.bold()
				ScrollView {
					LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
						ForEach(viewModel.movies, id: \.id) { movie in
							NavigationLink(destination: MovieDetailsView(movie: movie)) {
								PopularViewCell(movie: movie)
									.onAppear() {
										if movie.id == viewModel.movies.last?.id {
											viewModel.getMovies()
										}
									}
									.foregroundColor(.black)
							}
						}
					}.listStyle(.plain)
						.padding()
				}
			}
		}
	}
}

struct PopularViewCell : View {
	var movie: Movie
	private var imgURL: URL? = nil
	
	var body: some View {
		ZStack(alignment: .topTrailing) {
			AsyncImage(url: imgURL, content: { image in
				image.resizable()
					.frame(height: 200)
			}, placeholder: { Image(systemName: "photo.artframe") })
				.scaledToFit()
				.clipShape(RoundedRectangle(cornerRadius: 10))
			MovieRateView(rate: movie.voteAverage)
		}
	}
	
	init(movie: Movie) {
		if let tempImg = movie.posterPath {
			imgURL = URL(string: Api.baseImageURL+tempImg)
		}
		self.movie = movie
	}
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
			 .environmentObject(PopularViewModel())
    }
}
