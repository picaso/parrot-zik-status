import Cocoa

protocol ZikMemuInterface {
    func showMenu()
}

class ZikMenu: ZikMemuInterface {
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let menu = NSMenu()

    init () {}

    func showMenu() {
        if let button = statusItem.button {
            button.image = NSImage(named: "playStatus")
        }
        statusItem.menu = menu
    }
}
