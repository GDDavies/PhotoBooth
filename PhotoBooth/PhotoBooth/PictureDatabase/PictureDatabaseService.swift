//
//  PictureDatabaseService.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import Foundation

protocol PictureDatabaseServiceProtocol {
    func save(imageData: Data, with date: Date)
    func fetchUserImageDtos() -> [UserImageDto]
}

final class PictureDatabaseService: PictureDatabaseServiceProtocol {
    func save(imageData: Data, with date: Date) {
        
    }

    func fetchUserImageDtos() -> [UserImageDto] {
        return []
    }
}
