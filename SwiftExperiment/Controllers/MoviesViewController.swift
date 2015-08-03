import UIKit

public class MoviesViewController: UIViewController {
  public var moviesView: MoviesView! { return self.view as! MoviesView }

  var movies = [Movie]()
  var movieService: MovieServiceInterface = MovieService.sharedInstance
  var moviesPresenter = MoviesPresenter()

  public func configure(movieService movieService: MovieServiceInterface, moviesPresenter: MoviesPresenter) {
    self.movieService = movieService
    self.moviesPresenter = moviesPresenter
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    movieService.getMovies() {
      (movies, error) in
      if let movies = movies {
        self.movies = movies
        self.moviesPresenter.present(movies: movies, tableView: self.moviesView.tableView)
      } else if let error = error {
        print(error)
        let alertController = UIAlertController(title: "Error", message: "message", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alertController, animated: true) {}
      }
    }
  }

  override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowMovieDetailSegue" {
      if let
        tableView = moviesView.tableView,
        cell = sender as? UITableViewCell,
        indexPath = tableView.indexPathForCell(cell) {
          let movie = movies[indexPath.row]
          let movieDetailViewController = segue.destinationViewController as? MovieDetailViewController
          if let movieDetailViewController = movieDetailViewController {
            movieDetailViewController.configure(movie: movie)
          }
      }
    }
  }
}
