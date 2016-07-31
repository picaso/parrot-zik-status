import Cocoa
import FlatUIColors

class DisconnectedViewController: NSViewController, PopoverController, NSMenuDelegate {

    @IBOutlet weak var header: NSView!
    @IBOutlet weak var footer: Footer!
    var about: AboutProtocol?

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
        footer.backgroundColor = FlatUIColors.midnightBlueColor()
        view.backgroundColor = FlatUIColors.wetAsphaltColor()
    }

    @IBAction func about(sender: AnyObject) {
        about?.show()
    }

}
