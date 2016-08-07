import Swinject
import AppKit


class Footer: NSView {

    @IBOutlet var footer: NSView!
    @IBOutlet weak var deviceName: NSTextField!
    let container = SwinjectStoryboard.defaultContainer
    var about: AboutProtocol?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NSBundle.mainBundle().loadNibNamed("Footer", owner: self, topLevelObjects: nil)
        self.addSubview(footer)
        about = container.resolve(AboutProtocol)
    }

    func dialogOKCancel(question: String, text: String) -> Bool {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = question
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlertStyle.WarningAlertStyle
        myPopup.addButtonWithTitle("OK")
        myPopup.addButtonWithTitle("Cancel")
        self.window?.close()
        let res = myPopup.runModal()

        if res == NSAlertFirstButtonReturn {
            return true
        }
        return false
    }

    @IBAction func shutDown(view: NSView) {
        let answer = dialogOKCancel("Do you really want to quit ?",
                                    text: "Your headphone will not disconnect your headphone if connected")
        if answer {
            exit(0)
        }
    }

    @IBAction func about(sender: AnyObject) {
        about?.show()
    }

}
