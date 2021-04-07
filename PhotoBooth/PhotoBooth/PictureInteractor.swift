//
//  PictureInteractor.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import UIKit

protocol PictureInteractorProtocol {
    func save(image: UIImage) throws
    func fetchUserImages() -> [UserImage]
}

final class PictureInteractor: PictureInteractorProtocol {

    private let repository: PictureRepositoryProtocol

    init(repository: PictureRepositoryProtocol) {
        self.repository = repository
    }

    func save(image: UIImage) throws {
        try repository.save(image: image, with: Date())
    }
    func fetchUserImages() -> [UserImage] {
        repository.fetchUserImages()
    }
}
