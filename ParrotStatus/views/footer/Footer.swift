import Cocoa

class Footer: NSView {

    @IBOutlet var footer: NSView!
    @IBOutlet weak var deviceName: NSTextField!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NSBundle.mainBundle().loadNibNamed("Footer", owner: self, topLevelObjects: nil)
        self.addSubview(footer)
    }
}
