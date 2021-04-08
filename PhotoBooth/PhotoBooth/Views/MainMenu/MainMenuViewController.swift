//
//  ViewController.swift
//  PhotoBooth
//
//  Created by George Davies on 07/04/2021.
//

import UIKit

final class MainMenuViewController: UIViewController {

    private let stackView = UIStackView()
    private let takePictureButton = UIButton()
    private let viewPicturesButton = UIButton()

    private weak var coordinator: MainCoordinator?

    // MARK: - Init

    init(viewModel: MainMenuViewModel, coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupHierarchy()
        setupConstraints()
        update(with: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        stackView.axis = .vertical
        stackView.spacing = 60

        takePictureButton.addTarget(self, action: #selector(didTapTakePictureButton), for: .touchUpInside)
        viewPicturesButton.addTarget(self, action: #selector(didTapViewPicturesButton), for: .touchUpInside)

        [takePictureButton, viewPicturesButton].forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
            $0.backgroundColor = .systemBlue
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 6
            $0.setContentHuggingPriority(.required, for: .vertical)
        }
    }

    private func setupHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(takePictureButton)
        stackView.addArrangedSubview(viewPicturesButton)
    }

    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        takePictureButton.translatesAutoresizingMaskIntoConstraints = false
        viewPicturesButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),

            takePictureButton.heightAnchor.constraint(equalToConstant: 50),
            viewPicturesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Update

    private func update(with viewModel: MainMenuViewModel) {
        title = viewModel.title
        takePictureButton.setTitle(viewModel.takeImageTitle, for: .normal)
        viewPicturesButton.setTitle(viewModel.viewImagesTitle, for: .normal)
    }

    // MARK: - Button actions

    @objc
    private func didTapTakePictureButton() {
        coordinator?.didTapTakePictureButton()
    }

    @objc
    private func didTapViewPicturesButton() {
        coordinator?.didTapViewPicturesButton()
    }
}

