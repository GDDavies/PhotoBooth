//
//  PictureRepository.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import UIKit

protocol PictureRepositoryProtocol {
    func save(image: UIImage, with timestamp: Double) throws
    func fetchUserImages() -> [UserImage]
}

final class PictureRepository: PictureRepositoryProtocol {

    private let databaseService: PictureDatabaseServiceProtocol

    init(databaseService: PictureDatabaseServiceProtocol) {
        self.databaseService = databaseService
    }

    func save(image: UIImage, with timestamp: Double) throws {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            throw PictureRepositoryError.genericError
        }
        databaseService.save(imageData: imageData, with: timestamp)
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
