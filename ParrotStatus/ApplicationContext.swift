import Swinject

extension SwinjectStoryboard {
    class func setup() {

        defaultContainer.registerForStoryboard(ZikMenuViewController.self) { r, controller in
            controller.deviceState = r.resolve(DeviceState.self)
            controller.service = r.resolve(BTCommunicationServiceInterface.self)
            controller.about = r.resolve(AboutProtocol.self)
        }

        defaultContainer.registerForStoryboard(DisconnectedViewController.self) {r, controller in
            controller.about = r.resolve(AboutProtocol.self)
        }

        defaultContainer.register(ZikMemuInterface.self) { r in ZikMenu()
            }.inObjectScope(.Container)

        defaultContainer.register(AboutProtocol.self) { r in About()
            }.inObjectScope(.Container)

        defaultContainer.register(ParrotZik2Api.self) { _ in ParrotZik2Api() }
            .inObjectScope(.Container)

        defaultContainer.register(BTCommunicationServiceInterface.self) { r in
            BTCommunicationService(
                api: r.resolve(ParrotZik2Api)!,
                zikResponseHandler: r.resolve(BTResponseHandlerInterface)!)
            }.inObjectScope(.Container)

        defaultContainer.register(DeviceState.self) { _ in DeviceState() }
            .inObjectScope(.Container)

        defaultContainer.register(BTResponseHandlerInterface.self) { r in
            ZikResponseHandler(deviceState: r.resolve(DeviceState)!)
        }

        defaultContainer.register(BTConnectionServiceInterface.self) { r in
            BTConnectionService(service: r.resolve(BTCommunicationServiceInterface)!)
            }.inObjectScope(.Container)
    }
}
