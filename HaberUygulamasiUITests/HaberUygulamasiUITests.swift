import XCTest

final class HaberUygulamasiUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testTabBarNavigation() {
        XCTAssertTrue(app.tabBars.buttons["Ana Sayfa"].exists)
        app.tabBars.buttons["Arama"].tap()
        XCTAssertTrue(app.navigationBars["Arama"].exists)
        app.tabBars.buttons["Ayarlar"].tap()
        XCTAssertTrue(app.navigationBars["Ayarlar"].exists)
    }

    func testSliderAndCardExists() {
        let firstCard = app.scrollViews.otherElements.staticTexts.firstMatch
        XCTAssertTrue(firstCard.exists)
    }

    func testKaydedilenlerSekmesi() {
        app.tabBars.buttons["Kaydedilenler"].tap()
        XCTAssertTrue(app.staticTexts["Kaydedilen haberler burada gösterilecek."].exists)
    }
}
