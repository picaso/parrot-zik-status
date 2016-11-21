struct ParrotNotification {

    static func show(_ title: String, informativeText: String = String()) -> Void {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = informativeText
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default
            .deliver(notification)
    }

}
