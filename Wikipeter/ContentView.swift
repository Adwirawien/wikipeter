//
//  ContentView.swift
//  Wikipeter
//
//  Created by Adrian Böhme on 28.04.20.
//  Copyright © 2020 Adrian Böhme. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var lm = LocationManager()
    @State var settingsOpen: Bool = false
    @State var results: [Result] = []
    @State var pickerSelection = 0

    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }

    func loadSurroundingArticles() {
        DispatchQueue.main.async {
            let nearby = WikipediaFetcher().getArticlesNearby(latitude: self.lm.location?.latitude ?? 0, longitude: self.lm.location?.longitude ?? 0) { results in
                self.results = results
            }
        }
    }

    var body: some View {
        NavigationView {
            List {
                Picker("Options", selection: $pickerSelection) {
                    Text("Near you").tag(0)
                    Text("Map view").tag(1)
                }.pickerStyle(SegmentedPickerStyle())

                if (pickerSelection == 0) {
                    ForEach(results) { result in
                        SearchResultRow(result: result)
                            .background(Color.init(white: 0.95)).cornerRadius(7.5)
                    }
                } else {
                    VStack {
                        VStack {
                            MapView(results: $results)
                        }.frame(width: nil, height: 545, alignment: .top).cornerRadius(10)
                        HStack {
                            Spacer()
                            Text(lm.placemark?.name ?? "Searching location...").font(.footnote)
                            Spacer()
                        }.padding(.top)
                    }
                }
            }
                .navigationBarTitle("🥕 Wikipeter")
                .navigationBarItems(trailing:
                        Button(action: loadSurroundingArticles) {
                            Image(systemName: "arrow.clockwise")
                        }.font(Font.system(size: 23)))
        }.onAppear(perform: loadSurroundingArticles)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
