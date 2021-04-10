//
//  CameraViewModel.swift
//  PhotoBooth
//
//  Created by George Davies on 08/04/2021.
//

import UIKit

final class CameraViewModel {

    private let pictureInteractor: PictureInteractorProtocol

    init(pictureInteractor: PictureInteractorProtocol = PictureInteractor()) {
        self.pictureInteractor = pictureInteractor
    }

    func save(image: UIImage, withName name: String) throws {
        try pictureInteractor.save(image: image, with: name)
    }

}

extension CameraViewModel {
    enum SaveAlert {
        static let title = NSLocalizedString("Photo name", comment: "")
        static let message = NSLocalizedString("Give your photo a name", comment: "")
        static let save = NSLocalizedString("Save", comment: "")
        static let discard = NSLocalizedString("Discard", comment: "")
    }

    enum ErrorAlert {
        static let title = NSLocalizedString("Error", comment: "")
        static let ok = NSLocalizedString("OK", comment: "")

        static func message(localizedError: String) -> String {
            NSLocalizedString(localizedError, comment: "")
        }
    }

    enum Icons {
        static let captureImageButton = UIImage(named: "take_picture")
        static let captureImageButtonSelected = UIImage(named: "take_picture_selected")
    }
}
