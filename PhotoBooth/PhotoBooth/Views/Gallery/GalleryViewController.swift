//
//  GalleryViewController.swift
//  PhotoBooth
//
//  Created by George Davies on 08/04/2021.
//

import UIKit

final class GalleryViewController: UIViewController {

    private let tableView = UITableView(frame: .zero)

    private let viewModel: GalleryViewModel

    private weak var coordinator: MainCoordinator?

    // MARK: - Init

    init(viewModel: GalleryViewModel, coordinator: MainCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupHierarchy()
        setupConstraints()
        tableView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.backgroundColor = .systemBackground
        tableView.register(GalleryTableViewCell.self, forCellReuseIdentifier: GalleryTableViewCell.reuseIdentifier)
    }

    private func setupHierarchy() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

extension GalleryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUserImage = viewModel.cellModels[indexPath.item]
        coordinator?.didTapViewIndividualImage(image: selectedUserImage.image, name: selectedUserImage.name)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GalleryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: GalleryTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? GalleryTableViewCell else {
            return UITableViewCell()
        }
        cell.update(with: viewModel.cellModels[indexPath.row])
        return cell
    }
}
