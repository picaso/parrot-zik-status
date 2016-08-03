import Cocoa

class Footer: NSView {

    @IBOutlet var footer: NSView!
    @IBOutlet weak var deviceName: NSTextField!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NSBundle.mainBundle().loadNibNamed("Footer", owner: self, topLevelObjects: nil)
        self.addSubview(footer)
    }
    
    func dialogOKCancel(question: String, text: String) -> Bool {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = question
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlertStyle.WarningAlertStyle
        myPopup.addButtonWithTitle("OK")
        myPopup.addButtonWithTitle("Cancel")
        let res = myPopup.runModal()
        if res == NSAlertFirstButtonReturn {
            return true
        }
        return false
    }
    
    @IBAction func shutDown(view: NSView) {
        let answer = dialogOKCancel("Do you really want to quit ?", text: "")
        if(answer) {
            exit(0)
        }
    }
}
