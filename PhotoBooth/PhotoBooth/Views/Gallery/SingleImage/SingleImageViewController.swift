//
//  SingleImageViewController.swift
//  PhotoBooth
//
//  Created by George Davies on 10/04/2021.
//

import UIKit

final class SingleImageViewController: UIViewController {

    private let imageView = UIImageView()
    private let viewModel: SingleImageViewModel

    private weak var coordinator: MainCoordinator?

    // MARK: Init

    init(viewModel: SingleImageViewModel, coordinator: MainCoordinator) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupHierarchy()
        setupConstraints()
        update()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        view.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.image = viewModel.image
    }

    private func setupHierarchy() {
        view.addSubview(imageView)
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Update

    private func update() {
        title = viewModel.title
        imageView.image = viewModel.image
    }

    // MARK: - Action

    @objc
    func didTapClose() {
        coordinator?.dismissPresentedNavigationController()
    }
}
