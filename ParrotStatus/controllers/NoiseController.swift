import Cocoa
import FlatUIColors

class NoiseController: NSViewController {
    @IBOutlet weak var info: NSView!
    @IBOutlet weak var status: NSTextField!
    @IBOutlet weak var slider: NSSlider!

    var service: BTCommunicationServiceInterface?
    var deviceState: DeviceState! = nil

    override func viewWillAppear() {
        self.makeViewPretty()
        slider.integerValue = 2
        noiseControl(slider)
    }

    private func makeViewPretty() {
        view.backgroundColor = FlatUIColors.midnightBlueColor()
        info.backgroundColor = FlatUIColors.alizarinColor()
    }

    @IBAction func noiseControl(sender: NSSlider) {
        NSLog("\(sender.integerValue)")
        switch sender.integerValue {
        case 3:
            self.status.stringValue = "OFF"
        case 4:
            self.status.stringValue = "NORMAL"
        case 5:
            self.status.stringValue = "MAX"
        case 2:
            self.status.stringValue = "STREET"
        case 1:
            self.status.stringValue = "STREET MAX"
        default:
            self.status.stringValue = "OFF"
        }
    }

}
