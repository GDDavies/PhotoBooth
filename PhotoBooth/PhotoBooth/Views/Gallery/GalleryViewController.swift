//
//  GalleryViewController.swift
//  PhotoBooth
//
//  Created by George Davies on 08/04/2021.
//

import UIKit

final class GalleryViewController: UIViewController {

    // MARK: - Init

    init(viewModel: GalleryViewModel) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemRed
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
