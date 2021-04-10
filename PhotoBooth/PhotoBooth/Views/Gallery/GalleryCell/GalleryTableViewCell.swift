//
//  GalleryTableViewCell.swift
//  PhotoBooth
//
//  Created by George Davies on 10/04/2021.
//

import UIKit

final class GalleryTableViewCell: UITableViewCell {

    static let reuseIdentifier = "GalleryTableViewCell"

    private let horizontalStackView = UIStackView()
    private let thumbnailImageView = UIImageView()
    private let labelStackView = UIStackView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 8
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        thumbnailImageView.contentMode = .scaleAspectFit
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        titleLabel.textColor = .label
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .systemGray
    }

    private func setupHierarchy() {
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(thumbnailImageView)
        horizontalStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(dateLabel)
    }

    private func setupConstraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            thumbnailImageView.heightAnchor.constraint(equalToConstant: 60),
            thumbnailImageView.widthAnchor.constraint(equalTo: thumbnailImageView.heightAnchor)
        ])
    }

    // MARK: - Setup

    func update(with model: GalleryCellViewModel) {
        thumbnailImageView.image = model.image
        titleLabel.text = model.name
        dateLabel.text = model.date
    }

}
