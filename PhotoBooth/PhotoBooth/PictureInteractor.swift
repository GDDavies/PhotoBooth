//
//  PictureInteractor.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import UIKit

protocol PictureInteractorProtocol {
    func save(image: UIImage, with name: String) throws
    func fetchUserImages() -> [UserImage]
}

final class PictureInteractor: PictureInteractorProtocol {

    private let repository: PictureRepositoryProtocol

    init(repository: PictureRepositoryProtocol = PictureRepository()) {
        self.repository = repository
    }

    func save(image: UIImage, with name: String) throws {
        try repository.save(image: image, with: name, at: Date().timeIntervalSince1970)
    }
    func fetchUserImages() -> [UserImage] {
        repository.fetchUserImages()
    }
}
