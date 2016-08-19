import Cocoa
import IOBluetooth

protocol ZikMemuInterface {
    func showMenu()
    func menuStatusItem() -> NSStatusItem
}

class ZikMenu: NSObject, ZikMemuInterface, IOBluetoothRFCOMMChannelDelegate {
    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    private let disconnectedImage = NSImage(named: "icon-disconnected")
    private let connectedImage = NSImage(named: "icon-connected")

    private static let mainStoryBoard = NSStoryboard(name: "Main", bundle: nil)

    private var popover = NSPopover()
    private var detector: AnyObject?

    private let notificationCenter = NSNotificationCenter.defaultCenter()
    private let zikConnectedViewController = mainStoryBoard
        .instantiateControllerWithIdentifier("zikConnected") as? ZikMenuViewController
    private let zikDisconnectedViewController = mainStoryBoard
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

    private func createPopover(with controller: NSViewController) -> NSPopover {
        let popover = NSPopover()
        popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
        popover.animates = false
        popover.contentViewController = controller
        return popover
    }

    private func update(popover popover: NSPopover, with controller: NSViewController) {
        popover.contentViewController = controller
        popover.contentSize = controller.view.frame.size
    }

    private dynamic func disconnected() {
        if let button = statusItem.button {
            button.image = disconnectedImage
        }
        switchPopoverViewController(with: zikDisconnectedViewController!)
    }

    private dynamic func connected() {
        if let button = statusItem.button {
            button.image = connectedImage
        }
        switchPopoverViewController(with: zikConnectedViewController!)
    }

    private func switchPopoverViewController(with viewcontroller: NSViewController) {
        if popover.shown {
            update(popover: popover, with: viewcontroller)
        } else {
            popover = createPopover(with: viewcontroller)
        }
    }

    @objc private func togglePopOverView(sender: AnyObject) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }

    private func showPopover(sender: AnyObject?) {
        detector = NSEvent
            .addGlobalMonitorForEventsMatchingMask([
                NSEventMask.LeftMouseDownMask,
                NSEventMask.RightMouseDownMask,
                NSEventMask.KeyUpMask], handler: { [weak self] event in
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

    private func closePopover(sender: AnyObject?) {
        popover.close()
        if let temp: AnyObject = detector {
            NSEvent.removeMonitor(temp)
        }
    }

}
