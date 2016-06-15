import Cocoa
import FlatUIColors
protocol PopoverController: NSPopoverDelegate {}
class ZikMenuViewController: NSViewController, PopoverController {

    @IBOutlet weak var header: NSView!
    @IBOutlet weak var footer: NSView!

    @IBOutlet weak var deviceName: NSTextField!
    @IBOutlet weak var swVersion: NSTextField!
    @IBOutlet weak var percentage: NSTextField!

    var deviceState: DeviceState! = nil
    let notificationCenter = NSNotificationCenter.defaultCenter()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear() {
        preferredContentSize = view.fittingSize
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
            self.swVersion.stringValue = "Version: \(self.deviceState.version)"
            self.percentage.stringValue = "\(self.deviceState.batteryLevel)%"
            self.deviceName.stringValue = self.deviceState.name
        }
    }
}
