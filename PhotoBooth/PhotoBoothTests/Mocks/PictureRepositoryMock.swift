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

    func save(image: UIImage, with timestamp: Double) throws {
        let userImage = UserImage(timestamp: timestamp, image: image)
        userImages.append(userImage)
    }

    func fetchUserImages() -> [UserImage] {
        userImages
    }
}
