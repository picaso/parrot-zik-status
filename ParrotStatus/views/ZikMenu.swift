import Cocoa
import IOBluetooth

protocol ZikMemuInterface {
    func showMenu()
    func menuStatusItem() -> NSStatusItem
}

class ZikMenu: NSObject, ZikMemuInterface, IOBluetoothRFCOMMChannelDelegate {
    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)

    private var popover = NSPopover()
    private static let mainStoryBoard = NSStoryboard(name: "Main", bundle: nil)

    private let disconnectedImage = NSImage(named: "icon-disconnected")
    private let connectedImage = NSImage(named: "icon-connected")

    var detector: AnyObject?

    let notificationCenter = NSNotificationCenter.defaultCenter()

    let zikConnectedViewController = mainStoryBoard
        .instantiateControllerWithIdentifier("zikConnected") as? ZikMenuViewController
    let zikDisconnectedViewController = mainStoryBoard
        .instantiateControllerWithIdentifier("zikDisconnected") as? DisconnectedViewController

    override init() {
        super.init()
        disconnectedImage?.template = true
        connectedImage?.template = true
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

        popover = createPopover(with: zikDisconnectedViewController!)

    }

    private func createPopover(with controller: PopoverController) -> NSPopover {
        let popover = NSPopover()
        popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        popover.delegate = controller
        popover.animates = false
        popover.contentViewController = controller as? NSViewController
        return popover
    }

    private func update(popover popover: NSPopover, with controller: PopoverController) {
        let viewController = controller as? NSViewController
        popover.contentViewController = viewController
        popover.contentSize = viewController!.view.frame.size
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

    private dynamic func disconnected() {
        if let button = statusItem.button {
            button.image = disconnectedImage
        }
        if popover.shown {
            update(popover: popover, with: zikDisconnectedViewController!)
        } else {
            popover = createPopover(with: zikDisconnectedViewController!)
        }
    }

    private dynamic func connected() {
        if let button = statusItem.button {
            button.image = connectedImage
        }
        if popover.shown {
            update(popover: popover, with: zikConnectedViewController!)
        } else {
            popover = createPopover(with: zikConnectedViewController!)
        }
    }

    @objc private func togglePopOverView(sender: AnyObject) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }

    func showPopover(sender: AnyObject?) {
        detector = NSEvent
            .addGlobalMonitorForEventsMatchingMask([
                NSEventMask.LeftMouseDownMask,
                NSEventMask.RightMouseDownMask], handler: { [weak self] event in
            self?.closePopover(event)
            })

        if let button = statusItem.button {
            popover.showRelativeToRect(
                button.bounds,
                ofView: button,
                preferredEdge: NSRectEdge.MinY
            )
        }
    }

    func closePopover(sender: AnyObject?) {
        popover.close()
        if let temp: AnyObject = detector {
            NSEvent.removeMonitor(temp)
        }
    }

    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }

}
