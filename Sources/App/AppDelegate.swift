import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    private var coordinator: AppCoordinator!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.coordinator = AppCoordinator()
        self.coordinator.start(element: aNotification, completion: nil)
    }
    
}

