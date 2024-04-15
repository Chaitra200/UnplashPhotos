//
//  ViewController.swift
//  UnSplashApi
//
//  Created by Chaitra K on 15/04/24.
//

import UIKit

class ViewController: UIViewController{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let unsplashAccessKey = "JLP5RATqJ65WJosJDramKREZmFxgPvMlzT-TmnFljDA"
    var imageURLs: [URL] = [] // Array to store image URLs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchImages()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
    }
    
    func fetchImages(page: Int = 1, perPage: Int = 30, totalImagesToFetch: Int = 1000) {
        let imagesFetched = imageURLs.count
        if imagesFetched >= totalImagesToFetch {
            return // Already fetched required number of images
        }
        
        let remainingImagesToFetch = min(totalImagesToFetch - imagesFetched, perPage)
        guard var urlComponents = URLComponents(string: "https://api.unsplash.com/photos/random") else { return }
        
        let queryItems = [
            URLQueryItem(name: "count", value: "\(remainingImagesToFetch)"),
            URLQueryItem(name: "client_id", value: unsplashAccessKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch images:", error?.localizedDescription ?? "Unknown error")
                return
            }
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                let newImageURLs = photos.compactMap { URL(string: $0.urls.small) }
                self?.imageURLs.append(contentsOf: newImageURLs)
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
                // Fetch more images if needed
                let remainingImagesNeeded = totalImagesToFetch - (self?.imageURLs.count ?? 0)
                if remainingImagesNeeded > 0 {
                    let nextPage = page + 1
                    self?.fetchImages(page: nextPage, perPage: remainingImagesNeeded)
                }
            } catch {
                print("JSON decoding failed:", error.localizedDescription)
            }
        }.resume()
    }
 
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let imageURL = imageURLs[indexPath.item]
        cell.imageView.loadImage(from: imageURL)
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 10
        return CGSize(width: width, height: width)
    }
}
