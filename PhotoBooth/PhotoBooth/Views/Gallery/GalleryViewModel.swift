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
        let userImages = pictureInteractor.fetchUserImages()
        cellModels = userImages.map { GalleryCellViewModel(userImage: $0) }
    }

    convenience init(pictureDatabaseService: PictureDatabaseServiceProtocol) {
        let repository = PictureRepository(databaseService: pictureDatabaseService)
        self.init(
            pictureInteractor: PictureInteractor(repository: repository)
        )
    }
}
