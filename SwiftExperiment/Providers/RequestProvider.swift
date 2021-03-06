import Foundation

public class RequestProvider {
  #if Production
  let plistName = "Production"
  #else
  let pListName = "Test"
  #endif

  public init() {}

  public func getMoviesRequest() -> NSURLRequest? {
    if let
      pListFilePath = NSBundle.mainBundle().pathForResource(pListName, ofType: "plist"),
      pList = NSDictionary(contentsOfFile: pListFilePath),
      urlString = pList["MovieServiceURL"] as? String,
      apiKey = pList["MovieServiceAPIKey"] as? String,
      requestString = urlString + "?apikey=" + apiKey as? String,
      url = NSURL(string: requestString)
    {
      return NSURLRequest(URL: url)
    }
    return nil
  }
}
