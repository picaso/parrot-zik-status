/*
    A re-write of https://github.com/Swift-Kit/JZHoverNSButton/blob/master/JZHoverNSButton.swift
    Basically I want my buttons to give feedback of mouse over.
 */

class ButtonEffects: NSButton {

    var trackingArea: NSTrackingArea!

    // MARK: - Initializers
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        enableTracking()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        enableTracking()
    }

    fileprivate func enableTracking() {
        // set tracking area
        let opts: NSTrackingAreaOptions =
            [NSTrackingAreaOptions.mouseEnteredAndExited, NSTrackingAreaOptions.activeAlways]
        trackingArea = NSTrackingArea(rect: bounds, options: opts, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }

    // MARK: mouse events
    override func mouseEntered(with theEvent: NSEvent) {
            self.alphaValue = 0.5
    }

    override func mouseExited(with theEvent: NSEvent) {
            self.alphaValue = 1
    }

}

class PopUpButtonEffects: NSPopUpButton {
    var trackingArea: NSTrackingArea!

    // MARK: - Initializers
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setTrackingArea()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setTrackingArea()
    }

    fileprivate func setTrackingArea() {
        let opts: NSTrackingAreaOptions =
            [NSTrackingAreaOptions.mouseEnteredAndExited, NSTrackingAreaOptions.activeAlways]
        trackingArea = NSTrackingArea(rect: bounds, options: opts, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }

    // MARK: mouse events
    override func mouseEntered(with theEvent: NSEvent) {
        self.alphaValue = 0.5
    }

    override func mouseExited(with theEvent: NSEvent) {
        self.alphaValue = 1
    }

}
