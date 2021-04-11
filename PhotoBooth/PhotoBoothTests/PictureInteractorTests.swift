//
//  PictureInteractorTests.swift
//  PhotoBoothTests
//
//  Created by George Davies on 08/04/2021.
//

import XCTest
@testable import PhotoBooth

class PictureInteractorTests: XCTestCase {

    private var pictureInteractor: PictureInteractor!

    override func setUp() {
        super.setUp()
        let repository = PictureRepositoryMock()
        pictureInteractor = PictureInteractor(repository: repository)
    }

    func testSaveAndFetchImage() throws {
        let image = UIImage(systemName: "circle")!
        try pictureInteractor.save(image: image, with: "name")
        switch pictureInteractor.fetchUserImages() {
        case let .success(userImages):
            XCTAssertEqual(userImages.first?.image, image)

        case .failure:
            XCTFail()
        }
    }
}
