//
//  AlertBuilder.swift
//  PhotoBooth
//
//  Created by George Davies on 10/04/2021.
//

import UIKit

struct CameraAlertBuilder {

    private let viewModel: CameraViewModel

    init(viewModel: CameraViewModel) {
        self.viewModel = viewModel
    }

    func alertController(
        defaultAction: @escaping (UIAlertController) -> Void,
        destructiveAction: @escaping (UIAlertController) -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: CameraViewModel.SaveAlert.title,
            message: CameraViewModel.SaveAlert.message,
            preferredStyle: .alert
        )
        alertController.addTextField(configurationHandler: nil)
        let discardAction = UIAlertAction(
            title: CameraViewModel.SaveAlert.discard,
            style: .destructive
        ) { _ in
            destructiveAction(alertController)
        }
        alertController.addAction(discardAction)
        let saveAction = UIAlertAction(
            title: CameraViewModel.SaveAlert.save,
            style: .default
        ) { _ in
            defaultAction(alertController)
        }
        alertController.addAction(saveAction)
        return alertController
    }

    func errorAlertController(error: Error, defaultAction: @escaping (UIAlertController) -> Void) -> UIAlertController {
        let alertController = UIAlertController(
            title: CameraViewModel.ErrorAlert.title,
            message: CameraViewModel.ErrorAlert.message(localizedError: error.localizedDescription),
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: CameraViewModel.ErrorAlert.ok,
            style: .default
        ) { _ in
            defaultAction(alertController)
        }
        alertController.addAction(okAction)
        return alertController
    }


}
