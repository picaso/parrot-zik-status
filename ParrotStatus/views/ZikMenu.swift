import Cocoa

protocol ZikMemuInterface {
    func showMenu()
}

class ZikMenu: NSObject, ZikMemuInterface {
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let popover = NSPopover()
    let mainStoryBoard = NSStoryboard(name: "Main", bundle: nil)

    override init () {
        let vc = mainStoryBoard
            .instantiateControllerWithIdentifier("zikView") as? ZikMenuViewController
        popover.delegate = vc
        popover.contentViewController = vc!
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
