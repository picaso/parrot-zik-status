import Cocoa
import Swinject

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let container = SwinjectStoryboard.defaultContainer

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        container.resolve(ZikMemuInterface)?.showMenu()
        container.resolve(BTConnectionServiceInterface)
    }

}
