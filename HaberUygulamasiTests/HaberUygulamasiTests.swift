import XCTest
@testable import HaberUygulamasi

final class HaberUygulamasiTests: XCTestCase {
    var viewModel: NewsViewModel!

    override func setUpWithError() throws {
        viewModel = NewsViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testFetchNewsReturnsArticles() {
        let expectation = XCTestExpectation(description: "Haberler başarıyla çekilmeli")

        viewModel.fetchNews(category: "technology")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertGreaterThan(self.viewModel.articles.count, 0, "Haber sayısı 0'dan büyük olmalı")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testArticleModel() {
        let article = Article(title: "Başlık", description: "Açıklama", url: "https://example.com", urlToImage: nil)
        XCTAssertEqual(article.title, "Başlık")
        XCTAssertEqual(article.description, "Açıklama")
    }
}
