import Cocoa
import FlatUIColors

class DisconnectedViewController: NSViewController, NSMenuDelegate {

    @IBOutlet weak var header: NSView!
    @IBOutlet weak var footer: Footer!

    override func viewDidLoad() {
        super.viewDidLoad()
        NSApplication.shared().activate(ignoringOtherApps: true)
    }

    override func viewWillAppear() {
        preferredContentSize = view.fittingSize
        footer.deviceName.isHidden = true
        makeViewPretty()
    }

    fileprivate func makeViewPretty() {
        header.backgroundColor = FlatUIColors.midnightBlue()
        view.backgroundColor = FlatUIColors.wetAsphalt()
    }

}
