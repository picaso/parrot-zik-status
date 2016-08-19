import Cocoa
import FlatUIColors

class DisconnectedViewController: NSViewController, NSMenuDelegate {

    @IBOutlet weak var header: NSView!
    @IBOutlet weak var footer: Footer!

    override func viewDidLoad() {
        super.viewDidLoad()
        NSApplication.sharedApplication().activateIgnoringOtherApps(true)
    }

    override func viewWillAppear() {
        preferredContentSize = view.fittingSize
        footer.deviceName.hidden = true
        makeViewPretty()
    }

    private func makeViewPretty() {
        header.backgroundColor = FlatUIColors.midnightBlueColor()
        view.backgroundColor = FlatUIColors.wetAsphaltColor()
    }

}
