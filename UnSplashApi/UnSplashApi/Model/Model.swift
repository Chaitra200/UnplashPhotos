//
//  Model.swift
//  UnSplashApi
//
//  Created by Deepak A on 15/04/24.
//

import Foundation


struct Photo: Decodable {
    let urls: ImageURLs
}

struct ImageURLs: Decodable {
    let small: String
}
