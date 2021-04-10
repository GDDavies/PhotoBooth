//
//  PictureDatabaseService.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import Foundation

protocol PictureDatabaseServiceProtocol {
    func save(imageData: Data, with name: String, at timestamp: Double)
    func fetchUserImageDtos() -> [UserImageDto]
}

final class PictureDatabaseService: PictureDatabaseServiceProtocol {

    var temp: [UserImageDto] = []

    func save(imageData: Data, with name: String, at timestamp: Double) {
        let userImageDto = UserImageDto(timestamp: timestamp, imageData: imageData, name: name)
        temp.append(userImageDto)
    }

    func fetchUserImageDtos() -> [UserImageDto] {
        temp
    }
}
