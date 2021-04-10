//
//  Coordinator.swift
//  PhotoBooth
//
//  Created by George Davies on 08/04/2021.
//

import UIKit

final class MainCoordinator {

    private let pictureDatabaseService = PictureDatabaseService()

    private(set) var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        let mainMenuViewModel = MainMenuViewModel(
            title: NSLocalizedString("Photo Booth", comment: ""),
            takeImageTitle: NSLocalizedString("Take picture", comment: ""),
            viewImagesTitle: NSLocalizedString("View pictures", comment: "")
        )
        let mainMenuViewController = MainMenuViewController(
            viewModel: mainMenuViewModel,
            coordinator: self
        )
        navigationController.pushViewController(mainMenuViewController, animated: false)
    }

    func didTapTakePictureButton() {
        let cameraViewModel = CameraViewModel(pictureDatabaseService: pictureDatabaseService)
        let cameraViewController = CameraViewController(
            viewModel: cameraViewModel,
            coordinator: self
        )
        navigationController.pushViewController(cameraViewController, animated: true)
    }

    func didTapViewPicturesButton() {
        let galleryViewModel = GalleryViewModel(pictureDatabaseService: pictureDatabaseService)
        let galleryViewController = GalleryViewController(viewModel: galleryViewModel, coordinator: self)
        navigationController.pushViewController(galleryViewController, animated: true)
    }

    func didTapViewIndividualImage(image: UIImage) {
        
    }

    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}
