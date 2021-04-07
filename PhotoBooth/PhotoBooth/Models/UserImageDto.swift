//
//  UserImageDto.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import UIKit

struct UserImageDto {
   let date: Date
   let image: Data
}

extension UserImageDto {
    func toDomain() -> UserImage? {
        guard
            let image = UIImage(data: image)
        else {
            return nil
        }
        return UserImage(date: date, image: image)
    }
}
