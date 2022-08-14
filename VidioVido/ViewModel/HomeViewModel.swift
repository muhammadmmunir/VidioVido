//
//  HomeViewModel.swift
//  VidioVido
//
//  Created by Muhammad M Munir on 14/08/22.
//

import Foundation

protocol HomeViewModelInput {
    var contents: [Content] { get set }
    
    func viewDidLoad()
    func contentSize() -> Int
    func isPortrait(at index: Int) -> Bool
    func getSectionItems(at index: Int) -> [SectionCell.SectionItem]
}

protocol HomeViewModelOutput: AnyObject {
    func updateContent()
}

final class HomeViewModel {
    weak var view: HomeViewModelOutput?
    private var contentService: HomeServiceInterface
    
    var contents = [Content]()
    
    init(
        view: HomeViewModelOutput?,
        contentService: HomeServiceInterface = HomeService()
    ) {
        self.view = view
        self.contentService = contentService
        self.contentService.mockResponse = Mock.content
    }
    
    private func fetchContent() {
        self.contentService.fetch { [weak self] (result) in
            switch result {
            case .success(let contents):
                self?.contents = contents
                self?.view?.updateContent()
            case .failure(let error):
                print("fetchContent.failure.\(error)")
            }
        }
    }
}

// MARK: - HomeViewModelInput
extension HomeViewModel: HomeViewModelInput {
    func viewDidLoad() {
        self.fetchContent()
    }
    
    func contentSize() -> Int {
        self.contents.count
    }
    
    func isPortrait(at index: Int) -> Bool {
        self.contents[index].isPortait
    }
    
    func getSectionItems(at index: Int) -> [SectionCell.SectionItem] {
        self.contents[index].items.map {
            return (
                imageUrl: $0.imageUrl,
                title: $0.title
            )
        }
    }
}
