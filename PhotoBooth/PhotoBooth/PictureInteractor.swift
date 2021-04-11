//
//  PictureInteractor.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import UIKit

protocol PictureInteractorProtocol {
    func save(image: UIImage, with name: String) throws
    func fetchUserImages() -> Result<[UserImage], Error>
}

final class PictureInteractor: PictureInteractorProtocol {

    private let repository: PictureRepositoryProtocol

    init(repository: PictureRepositoryProtocol) {
        self.repository = repository
    }

    convenience init(pictureDatabaseService: PictureDatabaseServiceProtocol) {
        self.init(
            repository: PictureRepository(databaseService: pictureDatabaseService)
        )
    }

    func save(image: UIImage, with name: String) throws {
        try repository.save(image: image, with: name, at: Date().timeIntervalSince1970)
    }
    func fetchUserImages() -> Result<[UserImage], Error> {
        repository.fetchUserImages()
    }
}
