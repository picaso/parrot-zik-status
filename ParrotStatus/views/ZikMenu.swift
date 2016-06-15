import Cocoa
import IOBluetooth

protocol ZikMemuInterface {
    func showMenu()
}

class ZikMenu: NSObject, ZikMemuInterface, IOBluetoothRFCOMMChannelDelegate {
    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    private let popover = NSPopover()
    private static let mainStoryBoard = NSStoryboard(name: "Main", bundle: nil)

    let notificationCenter = NSNotificationCenter.defaultCenter()

    let zikConnectedViewController = mainStoryBoard
        .instantiateControllerWithIdentifier("zikConnected") as? ZikMenuViewController
    let zikDisconnectedViewController = mainStoryBoard
        .instantiateControllerWithIdentifier("zikDisconnected") as? DisconnectedViewController
    override init () {
        super.init()
        notificationCenter
            .addObserver(
                self, selector: #selector(connected),
                name: "connected",
                object: nil
        )
        notificationCenter
            .addObserver(
                self, selector: #selector(disconnected),
                name: "disconnected",
                object: nil
        )
        popover.delegate = zikDisconnectedViewController
        popover.contentViewController = zikDisconnectedViewController!
        popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        popover.behavior = .Transient
    }

    func showMenu() {
        if let button = statusItem.button {
            button.image = NSImage(named: "playStatus")
            button.action = #selector(ZikMenu.togglePopOverView(_:))
            button.target = self
        }
    }

    private dynamic func disconnected() {
        popover.delegate = zikDisconnectedViewController
        popover.contentViewController = zikDisconnectedViewController
//        zikConnectedViewController?.presentViewControllerAsModalWindow(zikDisconnectedViewController!)
    }

    private dynamic func connected() {
        print("WAAAAAAAAAAAAAAAAATTT")
        popover.delegate = zikConnectedViewController
        popover.contentViewController = zikConnectedViewController
//        zikDisconnectedViewController?.presentViewControllerAsModalWindow(zikConnectedViewController!)
    }

    @objc private func togglePopOverView(sender: AnyObject) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }

    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover
                .showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
    }

    func closePopover(sender: AnyObject?) {
        print("fuck")
        popover.performClose(sender)
    }

    func togglePopover(sender: AnyObject?) {
        print("fucker")
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}
