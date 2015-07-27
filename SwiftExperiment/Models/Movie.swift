public class Movie: Serializable {
  public let title: String

  public init(title: String) {
    self.title = title
  }

  public func serialize() -> Dictionary<String, AnyObject> {
    return ["title": title]
  }

  public convenience required init(dict: Dictionary<String, AnyObject>) {
    self.init(title: dict["title"] as! String)
  }
}

extension Movie: Equatable {}

public func ==(lhs: Movie, rhs: Movie) -> Bool {
  return lhs.title == rhs.title
}

