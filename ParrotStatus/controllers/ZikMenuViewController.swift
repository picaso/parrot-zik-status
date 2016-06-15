import Cocoa
import FlatUIColors

class ZikMenuViewController: NSViewController, NSPopoverDelegate {

    @IBOutlet weak var header: NSView!
    @IBOutlet weak var footer: NSView!

    var deviceState: DeviceState! = nil
    let notificationCenter = NSNotificationCenter.defaultCenter()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear() {
        makeViewPretty()
        notificationCenter
            .addObserver(
                self, selector: #selector(refreshView),
                name: "refreshDataState",
                object: nil
        )
        refreshView()
    }

    private func makeViewPretty() {
        header.backgroundColor = FlatUIColors.midnightBlueColor()
        footer.backgroundColor = FlatUIColors.midnightBlueColor()
        view.backgroundColor = FlatUIColors.wetAsphaltColor()
    }

    override var representedObject: AnyObject? {
        didSet {
        }
    }

    @objc private func refreshView() {
        dispatch_async(dispatch_get_main_queue()) {

        }
    }
}
