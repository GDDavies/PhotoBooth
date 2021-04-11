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
                with: "name 1",
                at: firstDate.timeIntervalSince1970
            )

            try pictureRepository.save(
                image: image,
                with: "name 2",
                at: secondDate.timeIntervalSince1970
            )

            let fetchedUserImagesResult = pictureRepository.fetchUserImages()
            switch fetchedUserImagesResult {
            case let .success(userImages):
                XCTAssertEqual(userImages.map { $0.date }, [firstDate, secondDate])
                XCTAssertEqual(userImages.map { $0.name }, ["name 1", "name 2"])
                let scaledImageSide = 60 * UIScreen.main.scale
                let expectedImageSize = CGSize(width: scaledImageSide, height: scaledImageSide)
                XCTAssert(userImages.allSatisfy { $0.thumbnail.size == expectedImageSize })

            case .failure:
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
}
