import Cocoa

protocol MenuControllerInterface {
    func showMenu()
}

class MenuController: MenuControllerInterface {
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let menu = NSMenu()

    init () {

    }

    func showMenu() {
        if let button = statusItem.button {
            button.image = NSImage(named: "playStatus")
        }

        menu.addItem(NSMenuItem(title: "Print Quote",
            action: Selector("printQuote:"),
            keyEquivalent: ""))
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Quit Quotes",
            action: Selector("terminate:"),
            keyEquivalent: ""))

        statusItem.menu = menu
    }
}
