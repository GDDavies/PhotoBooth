//
//  PictureDatabaseService.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import CoreData

protocol PictureDatabaseServiceProtocol {
    func save(userImageDto: UserImageDto) throws
    func fetchUserImageDtos() -> Result<[UserImageDto], Error>
}

final class PictureDatabaseService: PictureDatabaseServiceProtocol {

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhotoBooth")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func save(userImageDto: UserImageDto) throws {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(
            forEntityName: "StoredUserImage",
            in: context
        )!

        let userImage = NSManagedObject(
            entity: entity,
            insertInto: context
        )

        userImage.setValue(userImageDto.name, forKeyPath: "name")
        userImage.setValue(userImageDto.timestamp, forKeyPath: "timestamp")
        userImage.setValue(userImageDto.image, forKeyPath: "image")
        userImage.setValue(userImageDto.thumbnail, forKeyPath: "thumbnail")

        try context.save()
    }

    func fetchUserImageDtos() -> Result<[UserImageDto], Error> {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StoredUserImage")

        do {
            if let userImages = try context.fetch(fetchRequest) as? [DBUserImage] {
                let userImageDtos = userImages.map { $0.toDto() }
                return .success(userImageDtos)

            } else {
                return .failure(DatabaseError.generic)
            }

        } catch let error {
            return .failure(error)
        }
    }
}

extension PictureDatabaseService {
    enum DatabaseError: Error {
        case generic
    }
}
