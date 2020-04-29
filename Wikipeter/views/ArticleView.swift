//
//  ArticleView.swift
//  Wikipeter
//
//  Created by Adrian Böhme on 29.04.20.
//  Copyright © 2020 Adrian Böhme. All rights reserved.
//

import SwiftUI

struct ArticleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var articleResult: Result?
    @State var articleResults: [Result]
    @State var webViewHeight = 100
    
    var body: some View {
        ScrollView {
            VStack {
                if (articleResult != nil) {
                    MapView(results: $articleResults, latitude: articleResult!.lat, longitude: articleResult!.lon)
                    .cornerRadius(10)
                    .frame(width: nil, height: 300, alignment: .top)
                    .padding(.horizontal)

                WebView(request: URLRequest(url: URL(string: String("https://de.wikipedia.org/w/index.php?title=\(articleResult!.title.addingPercentEncoding(withAllowedCharacters: .letters)!)"))!))
                    .frame(width: nil, height: 10000, alignment: .top)
                } else {
                    Text("An error occured.")
                }
            } }
            .navigationBarTitle(articleResult?.title ?? "Error")

    }

}
