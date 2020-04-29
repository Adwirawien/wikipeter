//
//  SearchResultRow.swift
//  Wikipeter
//
//  Created by Adrian Böhme on 28.04.20.
//  Copyright © 2020 Adrian Böhme. All rights reserved.
//

import SwiftUI

struct SearchResultRow: View {
    @State var result: Result?
    typealias MethodAlias = (_ articleResult: Result) -> Void
    var loadArticle: MethodAlias
    
    var body: some View {
        Button(action: {self.loadArticle(self.result!)}) {
            HStack {
                Text(result!.title)
                    .fontWeight(.bold)
                    .font(.system(.body, design: .rounded))
                Spacer()
                Text("\(Double(result!.dist).removeZerosFromEnd())m")
            }
        }
    }
}
