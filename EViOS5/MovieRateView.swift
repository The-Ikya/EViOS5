//
//  SwiftUIView.swift
//  EViOS5
//
//  Created by Mavrik on 10/11/2022.
//

import SwiftUI

struct MovieRateView: View {
	let rate: CGFloat
	
    var body: some View {
		 ZStack {
			 Circle()
				 .stroke(.orange, lineWidth: 2)
				 .frame(width: 40, height: 40)
				 .background(Circle().foregroundColor(.white))
			 Text("\(rate.formatted())")
				 .font(.system(size: 20))
				 .fontWeight(.semibold)
		 }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
		 MovieRateView(rate: 8.3)
    }
}
