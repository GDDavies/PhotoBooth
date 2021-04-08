//
//  PictureRepositoryTests.swift
//  PhotoBoothTests
//
//  Created by George Davies on 07/04/2021.
//

import XCTest
@testable import PhotoBooth

class PictureRepositoryTests: XCTestCase {

    private var pictureRepository: PictureRepository!

    override func setUp() {
        super.setUp()
        let databaseService = PictureDatabaseServiceMock()
        pictureRepository = PictureRepository(databaseService: databaseService)
    }

    func testRepositoryThrowsWhenSavingInvalidImage() {
        do {
            try pictureRepository.save(image: UIImage(), with: Date().timeIntervalSince1970)
            XCTFail()
        } catch let error {
            let pictureRepositoryError = try? XCTUnwrap(error as? PictureRepository.PictureRepositoryError)
            XCTAssertEqual(pictureRepositoryError, .genericError)
        }
    }

    func testRepositoryDoesNotThrowWhenSavingValidImage() {
        do {
            try pictureRepository.save(
                image: UIImage(systemName: "circle")!,
                with: Date().timeIntervalSince1970
            )
            XCTAssert(true)
        } catch {
            XCTFail()
        }
    }

    func testRepositoryFetchesSavedUserImageDtos() {
        do {
            let firstTimestamp = Date().timeIntervalSince1970
            let secondTimestamp = Date().timeIntervalSinceNow
            let image = UIImage(systemName: "circle")!

            try pictureRepository.save(
                image: image,
                with: firstTimestamp
            )

            try pictureRepository.save(
                image: image,
                with: secondTimestamp
            )

            let fetchedUserImages = pictureRepository.fetchUserImages()
            XCTAssertEqual(fetchedUserImages.map { $0.timestamp }, [firstTimestamp, secondTimestamp])
        } catch {
            XCTFail()
        }
    }
}
