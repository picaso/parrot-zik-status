import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {

    class func setup() {

        defaultContainer.registerForStoryboard(ZikMenuViewController.self) { r, controller in
            controller.deviceState = r.resolve(DeviceState.self)
            controller.service = r.resolve(BTCommunicationServiceInterface.self)
            controller.about = r.resolve(AboutProtocol.self)
        }

        defaultContainer.registerForStoryboard(NoiseController.self) { r, controller in
            controller.deviceState = r.resolve(DeviceState.self)
            controller.service = r.resolve(BTCommunicationServiceInterface.self)
        }

        defaultContainer.register(ZikMemuInterface.self) { r in ZikMenu()
            }.inObjectScope(.container)

        defaultContainer.register(AboutProtocol.self) { r in About()
            }.inObjectScope(.container)

        defaultContainer.register(ParrotZik2Api.self) { _ in ParrotZik2Api() }
            .inObjectScope(.container)

        defaultContainer.register(BTCommunicationServiceInterface.self) { r in
            BTCommunicationService(
                api: r.resolve(ParrotZik2Api.self)!,
                zikResponseHandler: r.resolve(BTResponseHandlerInterface.self)!)
            }.inObjectScope(.container)

        defaultContainer.register(DeviceState.self) { _ in DeviceState() }
            .inObjectScope(.container)

        defaultContainer.register(BTResponseHandlerInterface.self) { r in
            ZikResponseHandler(deviceState: r.resolve(DeviceState.self)!)
        }

        defaultContainer.register(BTConnectionServiceInterface.self) { r in
            BTConnectionService(service: r.resolve(BTCommunicationServiceInterface.self)!)
            }.inObjectScope(.container)
    }

}
