import Foundation

protocol IntroViewPresenting: AnyObject {
    // Not defined yet
}

protocol IntroViewing: AnyObject {
    // Not defined yet
}

final class IntroViewPresenter: IntroViewPresenting {
    
    weak var view: IntroViewing?
    
    init(view: IntroViewing) {
        self.view = view
    }
    
}
