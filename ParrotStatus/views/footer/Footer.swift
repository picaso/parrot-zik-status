import Swinject
import AppKit
import FlatUIColors
import SwinjectStoryboard



class Footer: NSView {

    @IBOutlet var footer: NSView!
    @IBOutlet weak var deviceName: NSTextField!
    let container = SwinjectStoryboard.defaultContainer
    var about: AboutProtocol?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Bundle.main.loadNibNamed("Footer", owner: self, topLevelObjects: nil)
        self.addSubview(footer)
        about = container.resolve(AboutProtocol.self)
        footer.backgroundColor = FlatUIColors.midnightBlue()
    }

    func dialogOKCancel(_ question: String, text: String) -> Bool {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = question
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlertStyle.warning
        myPopup.addButton(withTitle: "OK")
        myPopup.addButton(withTitle: "Cancel")
        self.window?.close()
        let res = myPopup.runModal()

        if res == NSAlertFirstButtonReturn {
            return true
        }
        return false
    }

    @IBAction func shutDown(_ view: NSView) {
        let answer = dialogOKCancel("Do you really want to quit ?",
                                    text: "Will not disconnect your headphone if connected")
        if answer {
            exit(0)
        }
    }

    @IBAction func about(_ sender: AnyObject) {
        about?.show()
    }

}
