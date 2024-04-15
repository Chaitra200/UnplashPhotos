# UnplashPhotos
# UnplashPhotos

1. ViewController.swift
This file contains the main view controller of the application.
Purpose:
Handles the setup of the collection view and fetching of images from the Unsplash API.
Implements methods for setting up the collection view, fetching images, and displaying them.
Explanation:
setupCollectionView(): Sets up the collection view data source, delegate, and registers the custom cell.
fetchImages(): Fetches images from the Unsplash API using URLSession and handles the JSON decoding. It also fetches more images recursively until reaching the desired count.

2. ImageCell.swift
This file contains the custom UICollectionViewCell subclass for displaying images.
Purpose:
Defines the layout and behavior of the cell used in the collection view to display images.
Explanation:
ImageCell: Subclass of UICollectionViewCell responsible for displaying images.
imageView: UIImageView instance added to the cell to display the image.


3. Model.swift
This file contains the model structure for representing photo objects obtained from the Unsplash API.
Purpose:
Defines the structure of the photo objects fetched from the API.
Explanation:
Photo: Decodable struct representing a photo object.
ImageURLs: Decodable struct representing the URLs of the photo in different sizes.

4. UIImageView+Extensions.swift
This file contains an extension for UIImageView to load images asynchronously from a URL.
Purpose:
Provides a convenient method to load images asynchronously into a UIImageView.
Explanation:
loadImage(from url: URL): Asynchronously loads an image from the given URL using URLSession and updates the UIImageView once the image is loaded.

extension UIImageView { }: This syntax defines an extension of the UIImageView class. Extensions allow you to add new functionality to existing classes, structures, enumerations, or protocols without modifying their source code directly.

func loadImage(from url: URL) { }: This method within the extension is named loadImage(from:) and takes a URL parameter. It's responsible for asynchronously loading an image from the provided URL and updating the UIImageView once the image is fetched successfully.

URLSession.shared.dataTask(with: url) { data, response, error in }: This initiates an asynchronous network data task using the shared URLSession. It fetches data from the provided URL.

guard let data = data, error == nil else { }: This guard statement checks if the data (image data) is successfully obtained and if there are no errors. If either condition fails, it prints an error message and returns from the method.

DispatchQueue.main.async { self.image = UIImage(data: data) }: Inside the completion handler of the data task, this code sets the image property of the UIImageView to the image created from the fetched data. It's wrapped inside a DispatchQueue.main.async block to ensure UI updates occur on the main thread, which is necessary for UIKit operations.

.resume(): This method call resumes the network data task, initiating the data download operation.


How to Use
Clone or download the project.
Open the project in Xcode.
Run the application on a simulator or a physical iOS device.
The app will fetch random images from Unsplash and display them in a collection view.

Dependencies
None

Requirements
Xcode 12 or later
Swift 5.3 or later
iOS 13.0 or later

