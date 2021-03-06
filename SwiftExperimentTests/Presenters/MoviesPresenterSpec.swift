import Quick
import Nimble
import SwiftExperiment

class MoviesPresenterSpec: QuickSpec {
    override func spec() {
      var subject: MoviesPresenter!
      let cellPresenterDataSource = MockCellPresenterDataSource()

      beforeEach {
        cellPresenterDataSource.resetSentMessages()
        subject = MoviesPresenter(cellPresenterDataSource: cellPresenterDataSource)
      }

      describe("presentMoviesInTableView") {
        let movie0 = Movie(title: "Ratatouille")
        let movie1 = Movie(title: "Cars")
        var tableView: UITableView!

        beforeEach {
          tableView = UITableView()
          subject.present(movies: [movie0, movie1], tableView: tableView)
        }

        it("messages the cell presenter data source to display cell presenters in a table view") {
          expect(cellPresenterDataSource.display.wasReceived).to(beTrue())
        }

        it("passes to the cell presenter data source an array of cell presenters that have been configured with the movies") {
          let cellPresenters = cellPresenterDataSource.display.params.cellPresenters
          let cellPresenter0 = cellPresenters[0] as! MovieCellPresenter
          let cellPresenter1 = cellPresenters[1] as! MovieCellPresenter
          expect(cellPresenter0.movie).to(equal(movie0))
          expect(cellPresenter1.movie).to(equal(movie1))
        }

        it("passes to the cell presenter data source the table view") {
          expect(cellPresenterDataSource.display.params.tableView!).to(beIdenticalTo(tableView))
        }
      }
    }
}
