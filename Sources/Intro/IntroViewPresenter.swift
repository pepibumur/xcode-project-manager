import Foundation

protocol IntroViewPresenting: AnyObject {
    func viewDidLoad()
}

protocol IntroViewing: AnyObject {
    func setVersion(_ version: String)
}

final class IntroViewPresenter: IntroViewPresenting {
    
    weak var view: IntroViewing?
    let version: () -> String
    
    init(view: IntroViewing,
         version: @escaping () -> String = App.getVersion) {
        self.view = view
        self.version = version
    }
    
    func viewDidLoad() {
        self.view?.setVersion(version())
    }
    
}
