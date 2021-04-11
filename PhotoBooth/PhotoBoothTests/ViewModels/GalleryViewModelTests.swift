//
//  GalleryViewModelTests.swift
//  PhotoBoothTests
//
//  Created by George Davies on 10/04/2021.
//

import XCTest
@testable import PhotoBooth
import UIKit

class GalleryViewModelTests: XCTestCase {

    private var viewModel: GalleryViewModel!
    private var databaseService: PictureDatabaseServiceMock!
    private let image = UIImage(systemName: "circle")!

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm:ss a"
        return dateFormatter
    }()

    override func setUp() {
        super.setUp()
        databaseService = PictureDatabaseServiceMock()
    }

    func testCellModelsAreCorrectlyInitiliased_withEmptyImageArray() {
        databaseService.userImageDtos = []
        viewModel = GalleryViewModel(pictureDatabaseService: databaseService)
        XCTAssertEqual(viewModel.cellModels, [])
    }

    func testCellModelsAreCorrectlyInitiliased_withSingleImage() {
        let userImages = self.userImages(count: 1)
        databaseService.userImageDtos = userImages.map { $0.0 }
        viewModel = GalleryViewModel(pictureDatabaseService: databaseService)
        XCTAssertEqual(viewModel.cellModels, userImages.map { $0.1 })
    }

    func testCellModelsAreCorrectlyInitiliased_withMultipleImages() {
        let userImages = self.userImages(count: 3)
        databaseService.userImageDtos = userImages.map { $0.0 }
        viewModel = GalleryViewModel(pictureDatabaseService: databaseService)
        XCTAssertEqual(viewModel.cellModels, userImages.map { $0.1 })
    }

    private func userImages(count: Int) -> [(UserImageDto, GalleryCellViewModel)] {
        (0..<count).map {
            let dto = UserImageDto(
                name: "name " + $0.description,
                timestamp: Double($0),
                image: image.pngData()!,
                thumbnail: image.pngData()!
            )

            let cellModel = GalleryCellViewModel(
                name: "name " + $0.description,
                date: Self.dateFormatter.string(from: Date(timeIntervalSince1970: Double($0))),
                image: image,
                thumbnail: image
            )
            return (dto, cellModel)
        }
    }

}

extension GalleryCellViewModel: Equatable {
    public static func == (lhs: GalleryCellViewModel, rhs: GalleryCellViewModel) -> Bool {
        lhs.date == rhs.date &&
        lhs.name == rhs.name
    }
}
