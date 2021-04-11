//
//  MainMenuViewModel.swift
//  PhotoBooth
//
//  Created by George Davies on 08/04/2021.
//

import Foundation

struct MainMenuViewModel {
    let title: String
    let takeImageTitle: String
    let viewImagesTitle: String

    init() {
        title = NSLocalizedString("Photo Booth", comment: "")
        takeImageTitle = NSLocalizedString("Take photo", comment: "")
        viewImagesTitle = NSLocalizedString("View photos", comment: "")
    }
}
