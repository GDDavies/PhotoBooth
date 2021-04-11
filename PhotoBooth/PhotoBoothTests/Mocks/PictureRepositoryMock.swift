//
//  PictureRepositoryMock.swift
//  PhotoBoothTests
//
//  Created by George Davies on 08/04/2021.
//

@testable
import PhotoBooth
import UIKit

final class PictureRepositoryMock: PictureRepositoryProtocol {

    private var userImages: [UserImage] = []

    func save(image: UIImage, with name: String, at timestamp: Double) throws {
        let userImage = UserImage(
            name: name,
            date: Date(timeIntervalSince1970: timestamp),
            image: image,
            thumbnail: image
        )
        userImages.append(userImage)
    }

    func fetchUserImages() -> Result<[UserImage], Error> {
        .success(userImages)
    }
}
