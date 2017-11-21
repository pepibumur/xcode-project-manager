import Foundation
import RxSwift

enum RepositoryChange<T> {
    case upate(T)
    case remove
}

protocol ReadRepository {
    func read<T: Codable>(key: String) -> T?
}

protocol WriteRepository {
    func write<T: Codable>(_ value: T, key: String) throws
    func remove(key: String)
    func removeAll()
}

protocol ObservableRepository {
    func observe<T>(key: String) -> Observable<RepositoryChange<T>>
}

protocol ReadWriteRepository: WriteRepository, ReadRepository {}
