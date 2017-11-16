
//  LocalizationHelperTests.swift
//  FRLocalization
//
//  Created by Nikola Ristic on 8/4/17.
//  Copyright © 2017 nr. All rights reserved.
//

import XCTest
@testable import FRLocalization

class LocalizationHelperTests: XCTestCase {
    
    var localizationHelper: LocalizationHelper!
    
    override func setUp() {
        super.setUp()
        let dummyUserDefaults = UserDefaults()
        localizationHelper = LocalizationHelper(userDefaults: dummyUserDefaults)
    }
    
    override func tearDown() {
        localizationHelper = nil
        super.tearDown()
    }
    
    func testAvailableLanguages() {
        localizationHelper.userDefaults.set(["fr", "it"], forKey: "AppleLanguages")
        localizationHelper.userDefaults.synchronize()
        let result = localizationHelper.availableLanguages
        XCTAssert(result.count == 0)
    }
    
    func testCurrentLanguage() {
        let result = localizationHelper.currentLanguage
        XCTAssert(result == "en")
    }
    
    func testSetCurrentLanguage() {
        localizationHelper.userDefaults.set(["fr", "it"], forKey: "AppleLanguages")
        localizationHelper.userDefaults.synchronize()
        localizationHelper.currentLanguage = "en"
        let result = localizationHelper.userDefaults.value(forKey: "AppleLanguages") as? [String]
        XCTAssert(result?.first == "fr")
    }
    
    func testDefaultLanguage() {
        let result = localizationHelper.defaultLanguage()
        XCTAssert(result == "en")
    }
    
    func testDisplayName() {
        let result = localizationHelper.displayName(language: "en")
        XCTAssert(result == "English")
    }
    
}
