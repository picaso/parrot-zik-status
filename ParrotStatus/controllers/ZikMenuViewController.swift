import Cocoa
import FlatUIColors
import ITSwitch

protocol PopoverController: NSPopoverDelegate {}
class ZikMenuViewController: NSViewController, PopoverController {

    @IBOutlet weak var header: NSView!
    @IBOutlet weak var footer: NSView!

    @IBOutlet weak var deviceName: NSTextField!
    @IBOutlet weak var swVersion: NSTextField!
    @IBOutlet weak var percentage: NSTextField!
    @IBOutlet weak var batteryStatus: NSImageView!

    @IBOutlet weak var noiseControlStatus: ITSwitch!
    @IBOutlet weak var equalizerStatus: ITSwitch!

    var service: BTCommunicationServiceInterface?


    var deviceState: DeviceState! = nil
    let notificationCenter = NSNotificationCenter.defaultCenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        NSApplication
            .sharedApplication()
            .activateIgnoringOtherApps(true)

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

    private func updateBatteryStatus() {
        if deviceState.batteryStatus == "in_use" {
            switch Int(self.deviceState.batteryLevel)! {
            case 5..<20:
                self.batteryStatus.image = NSImage(named: "battery1")
            case 20..<51:
                self.batteryStatus.image = NSImage(named: "battery2")
            case 51..<90:
                self.batteryStatus.image = NSImage(named: "battery3")
            case 90..<101:
                self.batteryStatus.image = NSImage(named: "battery4")
            default:
                self.batteryStatus.image = NSImage(named: "batteryDead")
            }
        } else {
            self.batteryStatus.image = NSImage(named: "batteryCharging")
        }
    }

    @objc private func refreshView() {
        dispatch_async(dispatch_get_main_queue()) {
            self.updateBatteryStatus()
            self.noiseControlStatus.checked = self.deviceState.noiseCancellationEnabled
            self.equalizerStatus.checked = self.deviceState.equalizerEnabled
            self.swVersion.stringValue = "Version: \(self.deviceState.version)"
            self.percentage.stringValue = "\(self.deviceState.batteryLevel)%"
            self.deviceName.stringValue = self.deviceState.name
        }
    }

    @IBAction func noiseControlSwitch(sender: ITSwitch) {
        service?.toggleAsyncNoiseCancellation(sender.checked)
    }

    @IBAction func equalizerSwitch(sender: ITSwitch) {
        service?.toggleAsyncEqualizerStatus(sender.checked)
    }

}
