import XCTest
import AEXML


@testable import ParrotStatus

class ZikResponseHandlerTest: XCTestCase {
    var deviceState: DeviceState!
    var handler: ZikResponseHandler!

    override func setUp() {
        super.setUp()
        deviceState = DeviceState()
        handler = ZikResponseHandler(deviceState: deviceState)
    }

    override func tearDown() {
        super.tearDown()
        deviceState = nil
        handler = nil
    }

    func test_should_mutate_deviceState_version() {
        let answer = loadXml("SoftwareVersionAnswer")
        XCTAssert(deviceState.version == String(), "Device version not in empty state")
        handler.handle(answer!)
        XCTAssert(deviceState.version == "2.05", "Device version wasn't set pdroperly")
    }

    func test_should_mutate_deviceState_battery_info() {
        let answer = loadXml("BatteryInfoAnswer")
        XCTAssert(deviceState.batteryLevel == String(), "Battery Level not in empty state")
        XCTAssert(deviceState.batteryStatus == String(), "Battery Status not in empty state")
        handler.handle(answer!)
        XCTAssert(deviceState.batteryLevel == "74", "Battery Level not set properly")
        XCTAssert(deviceState.batteryStatus == "charging", "Battery Status not set properly")
    }
    func test_should_mutate_deviceState_battery_noise_cancellation_status() {
        let answer = loadXml("NoiseCancellationStatusAnswer")
        XCTAssert(deviceState.noiseCancellationEnabled == false)
        handler.handle(answer!)
        XCTAssert(deviceState.noiseCancellationEnabled == true, "Error setting noise cancellation")

    }
    private func loadXml(filePath: String) -> AEXMLDocument? {
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource(filePath, ofType: "xml")
        let content = NSData(contentsOfFile: path!)
        return try? AEXMLDocument(xmlData: content!)
    }

}
