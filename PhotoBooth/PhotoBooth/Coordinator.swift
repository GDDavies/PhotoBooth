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
    private var presentedNavigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        let mainMenuViewController = MainMenuViewController(
            viewModel: MainMenuViewModel(),
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

    func didTapViewIndividualImage(image: UIImage, name: String) {
        let singleImageViewModel = SingleImageViewModel(title: name, image: image)
        let singleImageViewController = SingleImageViewController(
            viewModel: singleImageViewModel,
            coordinator: self
        )
        let singleImageViewNavigationController = UINavigationController(rootViewController: singleImageViewController)
        self.presentedNavigationController = singleImageViewNavigationController
        navigationController.present(singleImageViewNavigationController, animated: true)
    }

    func dismissPresentedNavigationController(animated: Bool = true) {
        presentedNavigationController?.dismiss(animated: true) {
            self.presentedNavigationController = nil
        }
    }

    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}
