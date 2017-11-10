import Foundation

protocol Coordinator {

    associatedtype Element
    
    func start(element: Element?, completion: (() -> ())?)
    
}
