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
            try pictureRepository.save(
                image: UIImage(),
                with: "name",
                at: Date().timeIntervalSince1970
            )
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
                with: "name",
                at: Date().timeIntervalSince1970
            )
            XCTAssert(true)
        } catch {
            XCTFail()
        }
    }

    func testRepositoryFetchesSavedUserImageDtos() {
        do {
            let firstDate = Date(timeIntervalSinceReferenceDate: 0)
            let secondDate = Date(timeIntervalSinceReferenceDate: 0)
            let image = UIImage(systemName: "circle")!

            try pictureRepository.save(
                image: image,
                with: "name",
                at: firstDate.timeIntervalSince1970
            )

            try pictureRepository.save(
                image: image,
                with: "name",
                at: secondDate.timeIntervalSince1970
            )

            let fetchedUserImages = pictureRepository.fetchUserImages()
            XCTAssertEqual(fetchedUserImages.map { $0.date }, [firstDate, secondDate])
        } catch {
            XCTFail()
        }
    }
}
