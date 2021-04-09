//
//  CameraViewController.swift
//  PhotoBooth
//
//  Created by George Davies on 08/04/2021.
//

import UIKit

final class CameraViewController: UIViewController {

    private lazy var cameraController = CameraController(view: view)

    // MARK: - Init

    init(viewModel: CameraViewModel) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemGreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
