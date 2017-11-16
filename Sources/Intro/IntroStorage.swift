import Foundation
import RxSwift

class IntroStorage {

    // MARK: - RecentProject
    
    struct RecentProject: Equatable, Codable {
        let name: String
        let path: String
        let date: Date
        
        static func ==(lhs: RecentProject, rhs: RecentProject) -> Bool {
            return lhs.name == rhs.name && lhs.path == rhs.path
        }
    
    }
    
    // MARK: - Attributes
    
    var recentProjects: Variable<[RecentProject]> = Variable([])
    fileprivate let userDefaults: UserDefaults
    fileprivate let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        recentProjects
            .asObservable()
            .subscribe(onNext: { [weak self] (projects) in
            self?.synchronizeToUserDefaults(projects: projects)
        }).disposed(by: disposeBag)
        synchronizeFromUserDefaults()
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
    
    fileprivate func synchronizeFromUserDefaults() {
        guard let data = self.userDefaults.object(forKey: IntroStorage.userDefaultsKey) as? Data else { return }
        let decoder = JSONDecoder()
        guard let recentProjects = try? decoder.decode([RecentProject].self, from: data) else { return }
        self.recentProjects.value = recentProjects
    }
    
    fileprivate func synchronizeToUserDefaults(projects: [RecentProject]) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(projects) else { return }
        self.userDefaults.set(data, forKey: IntroStorage.userDefaultsKey)
        self.userDefaults.synchronize()
    }
    
}
