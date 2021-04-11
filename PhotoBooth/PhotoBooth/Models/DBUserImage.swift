//
//  DBUserImage.swift
//  PhotoBooth
//
//  Created by George Davies on 10/04/2021.
//

import CoreData

final class DBUserImage: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var timestamp: Double
    @NSManaged var image: Data
    @NSManaged var thumbnail: Data
}

extension DBUserImage {
    func toDto() -> UserImageDto {
        return UserImageDto(
            name: name,
            timestamp: timestamp,
            image: image,
            thumbnail: thumbnail
        )
    }
}

