import Cocoa

class ZikMenuViewController: NSViewController, NSPopoverDelegate {

    var deviceState: DeviceState! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("blaaaa")
        print(deviceState)
    }

    override var representedObject: AnyObject? {
        didSet {
        }
    }


}
