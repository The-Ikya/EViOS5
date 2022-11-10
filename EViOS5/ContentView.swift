//
//  ContentView.swift
//  EViOS5
//
//  Created by Mavrik on 10/11/2022.
//

import SwiftUI

struct ContentView: View {
	@State private var  selectedTab = 0
	
	init() {
		UITabBar.appearance().barTintColor = .orange
	}
	
    var body: some View {
		 TabView(selection: $selectedTab) {
			 SearchView()
				 .tabItem { Label("Search", systemImage: "magnifyingglass") }
				 .tag(0)
				 .environmentObject(SearchViewModel())
			 PopularView()
				 .tabItem { Label("Top Rated", systemImage: "star.fill") }
				 .tag(1)
				 .environmentObject(PopularViewModel())
		 }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
