import Cocoa
import FlatUIColors

class NoiseController: NSViewController {
    @IBOutlet weak var info: NSView!
    @IBOutlet weak var status: NSTextField!
    @IBOutlet weak var slider: NSSlider!

    var service: BTCommunicationServiceInterface?
    var deviceState: DeviceState! = nil
    let notificationCenter = NotificationCenter.default

    let sliderMap: [String: Int32] = [
        NoiseControlState.cancellingMax.urlParameter(): 5,
        NoiseControlState.cancellingOff.urlParameter(): 3,
        NoiseControlState.cancellingNormal.urlParameter(): 4,
        NoiseControlState.streetNormal.urlParameter(): 2,
        NoiseControlState.streetMax.urlParameter(): 1,
    ]

    override func viewWillAppear() {
        self.makeViewPretty()
        slider.integerValue = 2

        notificationCenter
            .addObserver(
                self, selector: #selector(refreshView),
                name: NSNotification.Name(rawValue: "refreshDataState"),
                object: nil
        )
        refreshView()
    }

    fileprivate func makeViewPretty() {
        view.backgroundColor = FlatUIColors.midnightBlue()
        info.backgroundColor = FlatUIColors.alizarin()
        self.view.window?.titleVisibility = .hidden
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.backgroundColor = FlatUIColors.midnightBlue()
    }

    @objc fileprivate func refreshView() {
        DispatchQueue.main.async {
            let noiseState = self.deviceState.noiseControlLevelState.urlParameter()
            self.slider.intValue = self.sliderMap[noiseState]!
            self.performAction(self.slider)
        }
    }


    @IBAction func noiseControl(_ sender: NSSlider) {
        performAction(sender, updateUIOnly: false)
    }

    fileprivate func performAction(_ slider: NSSlider, updateUIOnly: Bool = true) {

        switch slider.integerValue {
        case 3:
            self.status.stringValue = "OFF"
            if !updateUIOnly {
                service?.setNoiseControlLevel(NoiseControlState.cancellingOff)
            }
        case 4:
            self.status.stringValue = "NORMAL"
            if !updateUIOnly {
                service?.setNoiseControlLevel(NoiseControlState.cancellingNormal)
            }
        case 5:
            self.status.stringValue = "MAX"
            if !updateUIOnly {
                service?.setNoiseControlLevel(NoiseControlState.cancellingMax)
            }
        case 2:
            self.status.stringValue = "STREET"
            if !updateUIOnly {
                service?.setNoiseControlLevel(NoiseControlState.streetNormal)
            }
        case 1:
            self.status.stringValue = "STREET MAX"
            if !updateUIOnly {
                service?.setNoiseControlLevel(NoiseControlState.streetMax)
            }
        default:
            self.status.stringValue = "OFF"
            if !updateUIOnly {
                service?.setNoiseControlLevel(NoiseControlState.cancellingOff)
            }
        }
    }

 }
