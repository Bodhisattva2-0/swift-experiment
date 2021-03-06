import Quick
import Nimble
import SwiftExperiment

extension UIImage {
  func isEqualToByBytes(otherImage: UIImage) -> Bool {
    let imagePixelsData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
    let otherImagePixelsData = CGDataProviderCopyData(CGImageGetDataProvider(otherImage.CGImage))
    if let imagePixelsData = imagePixelsData,
      otherImagePixelsData = otherImagePixelsData {
        return imagePixelsData == otherImagePixelsData
    } else {
      return false
    }

  }
}

class ImageServiceSpec: QuickSpec {
    override func spec() {
      var subject: ImageService!
      let httpClient = MockHTTPClient()

      beforeEach {
        httpClient.resetSentMessages()
        subject = ImageService(httpClient: httpClient)
      }

      describe("fetchImage()") {
        var url: NSURL!
        var fetchedImage: UIImage!
        var sendRequestParams: MockHTTPClient.SendRequestParams!

        beforeEach {
          url = NSURL(string: "example.com")!
          subject.fetchImage(url: url) {
            (image) in
            fetchedImage = image
          }
          sendRequestParams = httpClient.sendRequestInvocation.params as! MockHTTPClient.SendRequestParams
        }

        it("messages the http client to make a request") {
          expect(httpClient.sendRequestInvocation.wasReceived).to(beTrue())
        }

        it("passes the request to the http client") {
          expect(sendRequestParams.request.URL).to(equal(url))
        }

        describe("when the request returns") {
          var closure: HTTPClientClosure!

          beforeEach {
            closure = sendRequestParams.closure
          }

          context("successfully") {
            var image: UIImage!

            beforeEach {
              let testBundle = NSBundle(forClass: ImageServiceSpec.self)
              image = UIImage(named: "kitten.jpg", inBundle: testBundle, compatibleWithTraitCollection: nil)
              if let image = image {
                let data = UIImageJPEGRepresentation(image, 1.0)
                closure(data: data, error: nil)
              } else {
                XCTFail()
              }
            }

//            it("calls the closure with the image data") {
//              expect(fetchedImage.isEqualToByBytes(image)).to(beTruthy())
//            }
          }

          context("with error") {
            it("doesn't do anything") {
            }
          }
        }
      }
    }
}
