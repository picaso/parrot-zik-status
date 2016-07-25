import Cocoa
import Swinject
import TRexAboutWindowController
import LetsMove


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var about: AboutProtocol?
    let container = SwinjectStoryboard.defaultContainer



    func applicationDidFinishLaunching(aNotification: NSNotification) {

        container.resolve(ZikMemuInterface)?.showMenu()
        container.resolve(BTConnectionServiceInterface)
        about = container.resolve(AboutProtocol)
    }

    func applicationWillFinishLaunching(notification: NSNotification) {
        if let _ = NSClassFromString("XCTest") {
            // Do nothing
        } else {
            PFMoveToApplicationsFolderIfNecessary()
        }
    }

    @IBAction func about(sender: AnyObject) {
        about?.show()
    }

}
