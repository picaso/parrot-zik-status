import XCTest
import AEXML
import Quick
import Nimble

@testable import ParrotStatus

class ZikResponseHandlerTest: QuickSpec {

    fileprivate func loadXml(_ filePath: String) -> AEXMLDocument? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: filePath, withExtension: "xml")
        let content = try? Data(contentsOf: path!)
        return try? AEXMLDocument(xml: content!)
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

            it("should mutate deviceState to reflect Equalizer status") {
                let answer = self.loadXml("EqualizerStatusAnswer")
                expect(deviceState.equalizerEnabled).to(beFalse())
                handler.handle(answer!)
                expect(deviceState.equalizerEnabled).to(beTrue())
            }

            it("should mutate deviceState to reflect Device name") {
                let answer = self.loadXml("DeviceNameAnswer")
                expect(deviceState.name).to(equal(String()))
                handler.handle(answer!)
                expect(deviceState.name).to(equal("Picaso"))
            }

            it("should mutate deviceState to reflect NoiseControl Level state") {
                let answer = self.loadXml("NoiseControlLevelAnswer")
                expect(deviceState.noiseControlLevelState)
                    .to(equal(NoiseControlState.cancellingNormal))
                handler.handle(answer!)
                expect(deviceState.noiseControlLevelState)
                    .to(equal(NoiseControlState.streetNormal))
            }

        }
    }

}
