//
//  CreateImage.swift
//  UnSplashApi
//
//  Created by Chaitra K on 15/04/24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image:", error?.localizedDescription ?? "Unknown error")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
