//
//  WikipediaFetcher.swift
//  Wikipeter
//
//  Created by Adrian Böhme on 28.04.20.
//  Copyright © 2020 Adrian Böhme. All rights reserved.
//

import Foundation

class WikipediaFetcher {
    func buildURL(languageCode: String, action: String, queries: Dictionary<String, Any>) -> URL? {
        var queryString: String = "";
        for (key, param) in queries {
            queryString += "&\(key)=\(param)"
        }
        queryString = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: "https://\(languageCode).wikipedia.org/w/api.php?origin=*&action=\(action)&format=json\(queryString)")
    }
    
    func buildGeosearchURL(languageCode: String,
        latitude: Double,
        longitude: Double,
        radius: Int,
        limit: Int) -> URL? {
        buildURL(languageCode: languageCode,
            action: "query",
            queries: ["list": "geosearch",
                "gscoord": "\(latitude)|\(longitude)",
                "gsradius": radius,
                "gslimit": limit
            ])
    }

}
