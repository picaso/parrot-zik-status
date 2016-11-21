import Cocoa
import Swinject
import LetsMove
import SwinjectStoryboard


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var about: AboutProtocol?
    let container = SwinjectStoryboard.defaultContainer

   
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        container.resolve(ZikMemuInterface.self)?.showMenu()
        let _ = container.resolve(BTConnectionServiceInterface.self)
        about = container.resolve(AboutProtocol.self)
    }

    
    func applicationWillFinishLaunching(_ aNotification: Notification) {
        if let _ = NSClassFromString("XCTest") {
            // Do nothing
        } else {
            PFMoveToApplicationsFolderIfNecessary()
        }
    }

    @IBAction func about(_ sender: AnyObject) {
        about?.show()
    }

}
