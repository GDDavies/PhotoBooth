//
//  SingleImageViewController.swift
//  PhotoBooth
//
//  Created by George Davies on 10/04/2021.
//

import UIKit

final class SingleImageViewController: UIViewController {

    // MARK: Init

    init(viewModel: SingleImageViewModel) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
