//
//  PictureDatabaseServiceMock.swift
//  PhotoBoothTests
//
//  Created by George Davies on 07/04/2021.
//

@testable
import PhotoBooth
import UIKit

final class PictureDatabaseServiceMock: PictureDatabaseServiceProtocol {

    private var userImageDtos: [UserImageDto] = []

    func save(imageData: Data, with timestamp: Double) {
        let userImageDto = UserImageDto(timestamp: timestamp, imageData: imageData)
        userImageDtos.append(userImageDto)
    }

    func fetchUserImageDtos() -> [UserImageDto] {
        userImageDtos
    }
}
