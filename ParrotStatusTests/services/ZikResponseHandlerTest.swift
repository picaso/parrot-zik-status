import XCTest
import AEXML
import Quick
import Nimble

@testable import ParrotStatus

class ZikResponseHandlerTest: QuickSpec {

    private func loadXml(filePath: String) -> AEXMLDocument? {
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource(filePath, ofType: "xml")
        let content = NSData(contentsOfFile: path!)
        return try? AEXMLDocument(xmlData: content!)
    }

    override func spec() {
        var deviceState: DeviceState!
        var handler: ZikResponseHandler!

        beforeEach {
            deviceState = DeviceState()
            handler = ZikResponseHandler(deviceState: deviceState)
        }

        describe("zik response handler") {
            it ("should mutate deviceState version") {
                let answer = self.loadXml("SoftwareVersionAnswer")
                expect(deviceState.version).to(beEmpty())
                handler.handle(answer!)
                expect(deviceState.version).to(equal("2.05"))
            }

            it ("should mutate deviceState battery info") {
                let answer = self.loadXml("BatteryInfoAnswer")
                expect(deviceState.batteryLevel).to(beEmpty())
                expect(deviceState.batteryStatus).to(beEmpty())
                handler.handle(answer!)
                expect(deviceState.batteryLevel).to(equal("74"))
                expect(deviceState.batteryStatus).to(equal("charging"))
            }

            it ("should mutate deviceState battery noise cancellation status") {
                let answer = self.loadXml("NoiseCancellationStatusAnswer")
                expect(deviceState.noiseCancellationEnabled).to(beFalse())
                handler.handle(answer!)
                expect(deviceState.noiseCancellationEnabled).to(beTrue())
            }

            it ("should mutate deviceState noise control status") {
                let answer = self.loadXml("NoiseControlStatusAnswer")
                expect(deviceState.noiseControlEnabled).to(beFalse())
                handler.handle(answer!)
                expect(deviceState.noiseControlEnabled).to(beTrue())
            }

            it("should mutate deviceState to reflect Concert hall status") {
                let answer = self.loadXml("ConcertHallStatusAnswer")
                expect(deviceState.concertHallEnabled).to(beFalse())
                handler.handle(answer!)
                expect(deviceState.concertHallEnabled).to(beTrue())
            }

            it("should mutate deviceState to reflect Head Detection status") {
                let answer = self.loadXml("HeadDetectionStatusAnswer")
                expect(deviceState.headDetectionEnabled).to(beFalse())
                handler.handle(answer!)
                expect(deviceState.headDetectionEnabled).to(beTrue())
            }

            it("should mutate deviceState to reflect Flight mode status") {
                let answer = self.loadXml("FlightModeStatusAnswer")
                expect(deviceState.flightModeEnabled).to(beFalse())
                handler.handle(answer!)
                expect(deviceState.flightModeEnabled).to(beTrue())
            }
        }
    }
}
