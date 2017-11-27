import Foundation
import RxSwift

// MARK: - RecentProject

struct RecentProject: Equatable, Codable {
    
    let name: String
    let path: String
    let date: Date
    
    static func ==(lhs: RecentProject, rhs: RecentProject) -> Bool {
        return lhs.name == rhs.name && lhs.path == rhs.path
    }
    
}

// MARK: - IntroInteracting

protocol IntroInteracting: AnyObject {
    var recentProjects: Variable<[RecentProject]> { get }
}

// MARK: - IntroInteractor

class IntroInteractor: IntroInteracting {
    
    // MARK: - Attributes
    
    var recentProjects: Variable<[RecentProject]> = Variable([])
    fileprivate let disposeBag: DisposeBag = DisposeBag()
    fileprivate let storage: KeyValueStoring
    
    // MARK: - Init
    
    init(storage: KeyValueStoring = Tools.settingsStorage) {
        self.storage = storage
        recentProjects
            .asObservable()
            .subscribe(onNext: { [weak self] (projects) in
            self?.synchronizeToUserDefaults(projects: projects)
        }).disposed(by: disposeBag)
        synchronizeFromStorage()
    }
    
    // MARK: - Internal
    
    func opened(project: RecentProject) {
        var newRecentProjects = recentProjects.value
        if let index = newRecentProjects.index(of: project) {
            newRecentProjects.remove(at: index)
        }
        newRecentProjects.insert(project, at: 0)
        recentProjects.value = newRecentProjects
    }
    
    func delete(project: RecentProject) {
        var newRecentProjects = recentProjects.value
        if let index = newRecentProjects.index(of: project) {
            newRecentProjects.remove(at: index)
        }
        recentProjects.value = newRecentProjects
    }
    
    // MARK: - Fileprivate
    
    static let userDefaultsKey: String = "recent_projects"
    
    fileprivate func synchronizeFromStorage() {
        let recentProjects: [RecentProject] = storage.read(key: IntroInteractor.userDefaultsKey) ?? []
        self.recentProjects.value = recentProjects
    }
    
    fileprivate func synchronizeToUserDefaults(projects: [RecentProject]) {
        do {
            try storage.write(projects, key: IntroInteractor.userDefaultsKey)
        } catch {
            // TODO
        }
    }
    
}
