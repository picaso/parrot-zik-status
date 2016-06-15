import Cocoa
import FlatUIColors


class DisconnectedViewController: NSViewController, NSPopoverDelegate {

    @IBOutlet weak var header: NSView!
    @IBOutlet weak var footer: NSView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear() {
        makeViewPretty()
    }

    private func makeViewPretty() {
        header.backgroundColor = FlatUIColors.midnightBlueColor()
        footer.backgroundColor = FlatUIColors.midnightBlueColor()
        view.backgroundColor = FlatUIColors.wetAsphaltColor()
    }

}
