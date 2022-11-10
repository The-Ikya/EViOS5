//
//  MovieDetailsView.swift
//  EViOS5
//
//  Created by Mavrik on 10/11/2022.
//

import SwiftUI

struct MovieDetailsView: View {
	@ObservedObject var viewModel: DetailViewModel
	private var imgURL: URL? = nil
	private var backImgURL: URL? = nil
	
    var body: some View {
		 ZStack {
			 VStack {
				 AsyncImage(url: backImgURL, content: { image in
					 image.resizable()
						 .frame(height: 250)
						 .scaledToFit()
				 }, placeholder: { Image(systemName: "photo.artframe") })
				 Spacer()
			 }.ignoresSafeArea()
			 VStack(alignment: .leading) {
				 HStack(alignment: .top) {
					 AsyncImage(url: imgURL, content: { image in
						 image.resizable()
							 .frame(maxWidth: 100, maxHeight: 150)
							 .scaledToFit()
							 .clipShape(RoundedRectangle(cornerRadius: 10))
					 }, placeholder: { Image(systemName: "photo.artframe") })
					 VStack {
						 Spacer()
						 Text(viewModel.movie.title).bold()
							 .font(.system(size: 30))
							 .multilineTextAlignment(.leading)
					 }
					 Spacer()
					 MovieRateView(rate: viewModel.movie.voteAverage)
				 }.frame(height: 150)
				 Text("Synopsis").bold()
				 ScrollView(.vertical) {
					 Text(viewModel.movie.overview)
				 }.frame(maxHeight: 125)
				 ScrollView(.horizontal) {
					 LazyHStack(alignment: .top) {
						 ForEach(viewModel.similarMovies, id: \.id) { movie in
							 SimilarViewCell(movie: movie)
								 .onTapGesture {
									 viewModel.movie = movie
								 }
						 }
					 }
				 }
			 }.padding()
				 .offset(y: 125)
		 }
    }
	
	init(movie: Movie) {
		viewModel = DetailViewModel(movie: movie)
		if let tempImg = movie.posterPath {
			imgURL = URL(string: Api.baseImageURL+tempImg)
		}
		if let backdropPath = movie.backdropPath, let url = URL(string: Api.baseImageURL+backdropPath) {
			self.backImgURL = url
		}
	}
}

struct SimilarViewCell: View {
	let movie: Movie
	private var imgURL: URL? = nil
	
	var body: some View {
		VStack {
			AsyncImage(url: imgURL, content: { image in
				image.resizable()
					.frame(width: 100)
					.scaledToFit()
					.clipShape(RoundedRectangle(cornerRadius: 10))
			}, placeholder: { Image(systemName: "photo.artframe") })
			Text(movie.title).bold()
				.font(.system(size: 15))
		}.frame(maxWidth: 100, maxHeight: 200)
	}
	
	init(movie: Movie) {
		self.movie = movie
		if let tempImg = movie.posterPath {
			imgURL = URL(string: Api.baseImageURL+tempImg)
		}
	}
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
		 MovieDetailsView(movie: Movie(voteAverage: 5.0, posterPath: nil, id: 0, genreIDS: nil, overview: "overview", title: "titletitletitletitletitletitletitletitletitletitletitletitletitle", backdropPath: nil))
    }
}
