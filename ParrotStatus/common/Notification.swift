struct Notification {

    static func show(title: String, informativeText: String = String()) -> Void {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = informativeText
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter
            .defaultUserNotificationCenter()
            .deliverNotification(notification)
    }

}
