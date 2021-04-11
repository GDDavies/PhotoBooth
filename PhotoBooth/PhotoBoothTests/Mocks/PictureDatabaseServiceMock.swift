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

    func save(userImageDto: UserImageDto) throws {
        userImageDtos.append(userImageDto)
    }

    func fetchUserImageDtos() -> Result<[UserImageDto], Error> {
        .success(userImageDtos)
    }
}
