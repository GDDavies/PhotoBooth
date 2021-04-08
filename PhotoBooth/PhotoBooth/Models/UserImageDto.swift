//
//  UserImageDto.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import UIKit

struct UserImageDto {
    let timestamp: Double
    let imageData: Data
}

extension UserImageDto {
    func toDomain() -> UserImage? {
        guard
            let image = UIImage(data: imageData)
        else {
            return nil
        }
        return UserImage(timestamp: timestamp, image: image)
    }
}
