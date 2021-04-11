//
//  PictureRepository.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import UIKit

protocol PictureRepositoryProtocol {
    func save(image: UIImage, with name: String, at timestamp: Double) throws
    func fetchUserImages() -> Result<[UserImage], Error>
}

final class PictureRepository: PictureRepositoryProtocol {

    private let databaseService: PictureDatabaseServiceProtocol

    init(databaseService: PictureDatabaseServiceProtocol = PictureDatabaseService()) {
        self.databaseService = databaseService
    }

    func save(image: UIImage, with name: String, at timestamp: Double) throws {
        guard
            let imageData = image.jpegData(compressionQuality: 1.0),
            let thumbnail = resizedImage(image, for: CGSize(width: 60, height: 60)),
            let thumbnailData = thumbnail.jpegData(compressionQuality: 1.0)
        else {
            throw PictureRepositoryError.genericError
        }

        let userImageDto = UserImageDto(
            name: name,
            timestamp: timestamp,
            image: imageData,
            thumbnail: thumbnailData
        )

        try databaseService.save(userImageDto: userImageDto)
    }

    func fetchUserImages() -> Result<[UserImage], Error> {
        let result = databaseService.fetchUserImageDtos()
        switch result {
        case let .success(userImageDtos):
            return .success(userImageDtos.compactMap { $0.toDomain() })

        case let .failure(error):
            return .failure(error)
        }
    }

    private func resizedImage(_ image: UIImage, for size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension PictureRepository {
    enum PictureRepositoryError: Error {
        case genericError
    }
}
