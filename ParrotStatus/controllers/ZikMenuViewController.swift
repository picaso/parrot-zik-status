import Cocoa
import FlatUIColors

extension NSView {
    var backgroundColor: NSColor? {
        get {
            guard let layer = layer, backgroundColor = layer.backgroundColor else { return nil }
            return NSColor(CGColor: backgroundColor)
        }

        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.CGColor
        }
    }
}

class ZikMenuViewController: NSViewController, NSPopoverDelegate {

    @IBOutlet weak var header: NSView!
    @IBOutlet weak var footer: NSView!

    var deviceState: DeviceState! = nil
    let notificationCenter = NSNotificationCenter.defaultCenter()




    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear() {
        header.backgroundColor = FlatUIColors.midnightBlueColor()
        footer.backgroundColor = FlatUIColors.midnightBlueColor()
        view.backgroundColor = FlatUIColors.wetAsphaltColor()
        notificationCenter
            .addObserver(
                self, selector: #selector(refreshView),
                name: "refreshDataState",
                object: nil
        )
        refreshView()
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
