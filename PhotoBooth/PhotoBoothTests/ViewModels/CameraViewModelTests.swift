//
//  CameraViewModelTests.swift
//  PhotoBoothTests
//
//  Created by George Davies on 10/04/2021.
//

import XCTest
@testable import PhotoBooth

class CameraViewModelTests: XCTestCase {

    private var viewModel: CameraViewModel!

    override func setUp() {
        super.setUp()
        let databaseService = PictureDatabaseServiceMock()
        viewModel = CameraViewModel(pictureDatabaseService: databaseService)
    }

    func testStringsAreCorrect() {
        XCTAssertEqual(CameraViewModel.SaveAlert.title, "Photo name")
        XCTAssertEqual(CameraViewModel.SaveAlert.message, "Give your photo a name")
        XCTAssertEqual(CameraViewModel.SaveAlert.save, "Save")
        XCTAssertEqual(CameraViewModel.SaveAlert.discard, "Discard")

        XCTAssertEqual(CameraViewModel.ErrorAlert.title, "Error")
        XCTAssertEqual(CameraViewModel.ErrorAlert.ok, "OK")
    }

}
