//
//  GalleryViewModel.swift
//  PhotoBooth
//
//  Created by George Davies on 08/04/2021.
//

import Foundation

final class GalleryViewModel {

    let cellModels: [GalleryCellViewModel]

    init(pictureInteractor: PictureInteractorProtocol) {
        let userImagesResult = pictureInteractor.fetchUserImages()
        switch userImagesResult {
        case let .success(userImages):
            cellModels = userImages.map { GalleryCellViewModel(userImage: $0) }

        case .failure:
            cellModels = []
        }
    }

    convenience init(pictureDatabaseService: PictureDatabaseServiceProtocol) {
        let repository = PictureRepository(databaseService: pictureDatabaseService)
        self.init(
            pictureInteractor: PictureInteractor(repository: repository)
        )
    }
}
