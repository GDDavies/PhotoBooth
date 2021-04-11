//
//  UserImageDto.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import UIKit

struct UserImageDto {
    let name: String
    let timestamp: Double
    let image: Data
    let thumbnail: Data
}

extension UserImageDto {
    func toDomain() -> UserImage? {
        guard
            let image = UIImage(data: image),
            let thumbnail = UIImage(data: thumbnail)
        else {
            return nil
        }
        return UserImage(
            name: name,
            date: Date(timeIntervalSince1970: timestamp),
            image: image,
            thumbnail: thumbnail
        )
    }
}
