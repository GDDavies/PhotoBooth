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
    func save(imageData: Data, with name: String, at timestamp: Double) {
        
    }

    func fetchUserImageDtos() -> [UserImageDto] {
        return []
    }
}
