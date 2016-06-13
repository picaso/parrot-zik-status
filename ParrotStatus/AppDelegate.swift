import Cocoa
import Swinject

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let container = Container() { container in
        container.register(ZikMemuInterface.self) { _ in ZikMenu() }
            .inObjectScope(.Container)
        container.register(ParrotZik2Api.self) { _ in ParrotZik2Api() }
            .inObjectScope(.Container)
        container.register(BTCommunicationServiceInterface.self) { r in
            BTCommunicationService(
                api: r.resolve(ParrotZik2Api)!,
                zikResponseHandler: r.resolve(BTResponseHandlerInterface)!)
        }.inObjectScope(.Container)
        container.register(DeviceState.self) { _ in DeviceState() }
        container.register(BTResponseHandlerInterface.self) { r in
            ZikResponseHandler(deviceState: r.resolve(DeviceState)!)
        }
        container.register(BTConnectionServiceInterface.self) { r in
            BTConnectionService(service: r.resolve(BTCommunicationServiceInterface)!)
        }.inObjectScope(.Container)
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSApplication.sharedApplication().windows.last!.close()
        container.resolve(ZikMemuInterface)?.showMenu()
        container.resolve(BTConnectionServiceInterface)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}
