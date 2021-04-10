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

    var userImageDtos: [UserImageDto] = []

    func save(imageData: Data, with name: String, at timestamp: Double) {
        let userImageDto = UserImageDto(timestamp: timestamp, imageData: imageData, name: name)
        userImageDtos.append(userImageDto)
    }

    func fetchUserImageDtos() -> [UserImageDto] {
        userImageDtos
    }
}
