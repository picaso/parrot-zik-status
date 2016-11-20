import Cocoa
import IOBluetooth

protocol ZikMemuInterface {
    func showMenu()
    func menuStatusItem() -> NSStatusItem
}

class ZikMenu: NSObject, ZikMemuInterface, IOBluetoothRFCOMMChannelDelegate {
    fileprivate let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    fileprivate let disconnectedImage = NSImage(named: "icon-disconnected")
    fileprivate let connectedImage = NSImage(named: "icon-connected")

    fileprivate static let mainStoryBoard = NSStoryboard(name: "Main", bundle: nil)

    fileprivate var popover = NSPopover()
    fileprivate var detector: AnyObject?

    fileprivate let notificationCenter = NotificationCenter.default
    fileprivate let zikConnectedViewController = mainStoryBoard
        .instantiateController(withIdentifier: "zikConnected") as? ZikMenuViewController
    fileprivate let zikDisconnectedViewController = mainStoryBoard
        .instantiateController(withIdentifier: "zikDisconnected") as? DisconnectedViewController

    override init() {
        super.init()
        disconnectedImage?.isTemplate = true
        connectedImage?.isTemplate = true
        notificationCenter
            .addObserver(
                self, selector: #selector(connected),
                name: NSNotification.Name(rawValue: "connected"),
                object: nil
        )
        notificationCenter
            .addObserver(
                self, selector: #selector(disconnected),
                name: NSNotification.Name(rawValue: "disconnected"),
                object: nil
        )
        popover = createPopover(with: zikDisconnectedViewController!)
    }

    func showMenu() {
        if let button = statusItem.button {
            button.image = disconnectedImage
            button.action = #selector(ZikMenu.togglePopOverView(_:))
            button.target = self
        }
    }

    func menuStatusItem() -> NSStatusItem {
        return statusItem
    }

    fileprivate func createPopover(with controller: NSViewController) -> NSPopover {
        let popover = NSPopover()
        popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        popover.animates = false
        popover.contentViewController = controller
        return popover
    }

    fileprivate func update(popover: NSPopover, with controller: NSViewController) {
        popover.contentViewController = controller
        popover.contentSize = controller.view.frame.size
    }

    fileprivate dynamic func disconnected() {
        if let button = statusItem.button {
            button.image = disconnectedImage
        }
        switchPopoverViewController(with: zikDisconnectedViewController!)
    }

    fileprivate dynamic func connected() {
        if let button = statusItem.button {
            button.image = connectedImage
        }
        switchPopoverViewController(with: zikConnectedViewController!)
    }

    fileprivate func switchPopoverViewController(with viewcontroller: NSViewController) {
        if popover.isShown {
            update(popover: popover, with: viewcontroller)
        } else {
            popover = createPopover(with: viewcontroller)
        }
    }

    @objc fileprivate func togglePopOverView(_ sender: AnyObject) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }

    fileprivate func showPopover(_ sender: AnyObject?) {
        detector = NSEvent
            .addGlobalMonitorForEvents(matching: [
                NSEventMask.leftMouseDown,
                NSEventMask.rightMouseDown,
                NSEventMask.keyUp], handler: { [weak self] event in
            self?.closePopover(event)
            }) as AnyObject?

        if let button = statusItem.button {
            popover.show(
                relativeTo: button.bounds,
                of: button,
                preferredEdge: NSRectEdge.minY
            )
        }
    }

    fileprivate func closePopover(_ sender: AnyObject?) {
        popover.close()
        if let temp: AnyObject = detector {
            NSEvent.removeMonitor(temp)
        }
    }

}
