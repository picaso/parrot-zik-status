import AppKit

class SetingsMenu: NSMenu {

    override init(title aTitle: String) {
        super.init(title: aTitle)
    }

    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
