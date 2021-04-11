//
//  CameraViewController.swift
//  PhotoBooth
//
//  Created by George Davies on 08/04/2021.
//

import UIKit

final class CameraViewController: UIViewController {

    private let captureImageButton = UIButton()
    private let imageView = UIImageView()

    private lazy var cameraController = CameraController(view: view)

    private weak var coordinator: MainCoordinator?

    private let viewModel: CameraViewModel
    private lazy var alertBuilder = CameraAlertBuilder(viewModel: viewModel)

    // MARK: - Init

    init(viewModel: CameraViewModel, coordinator: MainCoordinator?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        captureImageButton.setImage(CameraViewModel.Icons.captureImageButton, for: .normal)
        captureImageButton.setImage(CameraViewModel.Icons.captureImageButtonSelected, for: .selected)
        captureImageButton.addTarget(self, action: #selector(didTapTakePhotoButton), for: .touchUpInside)
        captureImageButton.tintColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(imageView)
        view.addSubview(captureImageButton)
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        captureImageButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            captureImageButton.heightAnchor.constraint(equalToConstant: 64),
            captureImageButton.widthAnchor.constraint(equalTo: captureImageButton.heightAnchor),
            captureImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureImageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        try? cameraController.startSession()
    }

    // MARK: - Actions

    @objc
    private func didTapTakePhotoButton() {
        cameraController.takePhoto { [weak self] result in
            guard let self = self else { return }
            let alert: UIAlertController

            switch result {
            case let .success(image):
                self.imageView.isHidden = false
                self.imageView.image = image
                self.captureImageButton.isEnabled = false

                alert = self.alertBuilder.alertController(
                    defaultAction: { [weak self] alertController in
                        self?.didTapSave(image: image, alertController: alertController)
                    },
                    destructiveAction: { [weak self] alertController in
                        self?.didTapDiscard(alertController: alertController)
                    }
                )

            case let .failure(error):
                alert = self.alertBuilder.errorAlertController(
                    error: error,
                    defaultAction: { [weak self] alertController in
                        self?.didTapOK(alertController: alertController)
                    }
                )
            }
            self.present(alert, animated: true)
        }
    }

    private func didTapSave(image: UIImage, alertController: UIAlertController) {
        guard let textField = alertController.textFields?.first else { return }
        do {
            try viewModel.save(image: image, withName: textField.text ?? "")
            coordinator?.pop()

        } catch let error {
            let alert = alertBuilder.errorAlertController(
                error: error,
                defaultAction: didTapOK
            )
            present(alert, animated: true)
        }
    }

    private func didTapDiscard(alertController: UIAlertController) {
        resetViews()
        alertController.dismiss(animated: true)
    }

    private func didTapOK(alertController: UIAlertController) {
        resetViews()
        alertController.dismiss(animated: true)
    }

    private func resetViews() {
        imageView.isHidden = true
        imageView.image = nil
        captureImageButton.isEnabled = true
    }
}
