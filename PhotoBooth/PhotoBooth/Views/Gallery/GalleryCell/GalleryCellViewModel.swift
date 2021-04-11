//
//  GalleryCellViewModel.swift
//  PhotoBooth
//
//  Created by George Davies on 10/04/2021.
//

import UIKit

struct GalleryCellViewModel {
    let name: String
    let date: String
    let image: UIImage
    let thumbnail: UIImage

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm:ss a"
        return dateFormatter
    }()

    init(name: String, date: String, image: UIImage, thumbnail: UIImage) {
        self.name = name
        self.date = date
        self.image = image
        self.thumbnail = thumbnail
    }

    init(userImage: UserImage) {
        name = userImage.name
        date = Self.dateFormatter.string(from: userImage.date)
        image = userImage.image
        thumbnail = userImage.thumbnail
    }
}
