//
//  PictureRepository.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import UIKit

protocol PictureRepositoryProtocol {
    func save(image: UIImage, with date: Date) throws
    func fetchUserImages() -> [UserImage]
}

final class PictureRepository: PictureRepositoryProtocol {

    private let databaseService: PictureDatabaseServiceProtocol

    init(databaseService: PictureDatabaseServiceProtocol) {
        self.databaseService = databaseService
    }

    func save(image: UIImage, with date: Date) throws {
        guard let imageData = image.pngData() else {
            throw PictureRepositoryError.genericError
        }
        databaseService.save(imageData: imageData, with: date)
    }

    func fetchUserImages() -> [UserImage] {
        let userImageDtos = databaseService.fetchUserImageDtos()
        return userImageDtos.compactMap { $0.toDomain() }
    }
}

extension PictureRepository {
    enum PictureRepositoryError: Error {
        case genericError
    }
}
