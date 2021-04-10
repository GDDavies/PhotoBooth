//
//  GalleryCellViewModel.swift
//  PhotoBooth
//
//  Created by George Davies on 10/04/2021.
//

import UIKit

struct GalleryCellViewModel {
    let image: UIImage
    let name: String
    let date: String

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm:ss a"
        return dateFormatter
    }()

    init(userImage: UserImage) {
        image = userImage.image
        name = userImage.name
        date = Self.dateFormatter.string(from: userImage.date)
    }
}
