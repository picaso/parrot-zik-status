import Foundation
import TRexAboutWindowController

protocol AboutProtocol {
    func show()
}

class About: AboutProtocol {

    var aboutWindowController: TRexAboutWindowController

    init() {
        self.aboutWindowController = TRexAboutWindowController(windowNibName: "PFAboutWindow")
        self.aboutWindowController.appURL = NSURL(string:"https://github.com/T-Rex-Editor/")!
        self.aboutWindowController.appName = "Parrot Status"
        let font: NSFont? = NSFont(name: "HelveticaNeue", size: 11.0)
        let color: NSColor? = NSColor.tertiaryLabelColor()
        let attribs: [String:AnyObject] = [NSForegroundColorAttributeName:color!,
                                          NSFontAttributeName:font!]

        self.aboutWindowController.appCopyright =
            NSAttributedString(string: "Copyright (c) 2016 Osaide (picaso)", attributes: attribs)

        self.aboutWindowController.windowShouldHaveShadow = true
    }

    func show() {
        self.aboutWindowController .showWindow(nil)
    }
}
