//
//  SearchView.swift
//  EViOS5
//
//  Created by Mavrik on 10/11/2022.
//

import SwiftUI

struct SearchView: View {
	@EnvironmentObject var viewModel : SearchViewModel
	
    var body: some View {
		 VStack {
			 ActionBarView()
//				 .clipShape(RoundedRectangle(cornerRadius: 20))
//				 .ignoresSafeArea()
			 List {
				 ForEach(viewModel.movies, id: \.id) { movie in
					 SearchViewCell(movie: movie)
				 }
			 }.listStyle(.plain)
		 }
    }
}

struct ActionBarView: View {
	@EnvironmentObject var viewModel : SearchViewModel
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("Search")
				.foregroundColor(.white)
				.font(.system(size: 30))
				.fontWeight(.semibold)
			ZStack(alignment: .leading) {
				RoundedRectangle(cornerRadius: 10)
					.frame(height: 40)
					.foregroundColor(.white)
				Button(action: {
					viewModel.getMovies()
				}, label: {Image(systemName: "magnifyingglass")}).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
				TextField("Search", text: $viewModel.currentSearchStr).padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
			}
		}
		.padding()
		.background(Color.orange)
	}
}

struct SearchViewCell : View {
	let movie: Movie
	private var imgURL: URL? = nil
	
	var body: some View {
		HStack {
			AsyncImage(url: imgURL, content: { image in
				image.resizable()
					.scaledToFit()
					.clipShape(RoundedRectangle(cornerRadius: 10))
			}, placeholder: { Image(systemName: "photo.artframe") })
			VStack {
				Text(movie.title)
					.bold()
				Text(movie.title)
			}
		}
		.frame(height: 100)
	}
	
	init(movie: Movie) {
		if let tempImg = movie.posterPath {
			imgURL = URL(string: Api.baseImageURL+tempImg)
		}
		self.movie = movie
	}
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
			 .environmentObject(SearchViewModel())
    }
}
