import Foundation

protocol IntroWindowPresenting: AnyObject {
    // Not defined yet
}

protocol IntroWindowing: AnyObject {
    // Not defined yet
}

final class IntroWindowPresenter: IntroWindowPresenting {
    
    weak var window: IntroWindowing?
    
    init(window: IntroWindowing) {
        self.window = window
    }
    
}
