import Quick
import Nimble
import SwiftExperiment

class MovieDetailViewControllerSpec: QuickSpec {
  override func spec() {
    var subject: MovieDetailViewController!
    var viewPresenter: MockMovieDetailViewPresenter!
    let movie = Movie(title: "A Title")

    beforeEach {
      subject = MovieDetailViewController.getInstanceFromStoryboard("Main") as! MovieDetailViewController
      viewPresenter = MockMovieDetailViewPresenter()
      expect(viewPresenter.receivedPresentInView).to(beFalsy())
      subject.configure(movie: movie, movieDetailViewPresenter: viewPresenter)

      expect(subject.view).notTo(beNil())
    }

    it("sets the movie on the view presenter") {
    }

    describe("when the view loads") {
      it("sets the title label text") {
        expect(viewPresenter.receivedPresentInView).to(beTruthy())
      }
    }
  }
}
