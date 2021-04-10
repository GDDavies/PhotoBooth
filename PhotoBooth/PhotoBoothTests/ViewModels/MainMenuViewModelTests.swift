//
//  MainMenuViewModelTests.swift
//  PhotoBoothTests
//
//  Created by George Davies on 08/04/2021.
//

import XCTest
@testable import PhotoBooth

class MainMenuViewModelTests: XCTestCase {

    private var viewModel: MainMenuViewModel!

    override func setUp() {
        super.setUp()
        viewModel = MainMenuViewModel()
    }

    func testStringsAreCorrect() {
        XCTAssertEqual(viewModel.title, "Photo Booth")
        XCTAssertEqual(viewModel.takeImageTitle, "Take picture")
        XCTAssertEqual(viewModel.viewImagesTitle, "View pictures")
    }

}
