//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

/// ViewModel que representa un listado de topics
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [TopicCellViewModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    func viewWasLoaded() {
        topicsDataManager.fetchAllTopics{[weak self] (result) in
            switch result {
            case .success(let lastestTopicsResponse):
                guard let topicsUnw = lastestTopicsResponse?.topicList.topics else {return}
                self?.topicViewModels.removeAll()
                topicsUnw.forEach({topic in self?.topicViewModels.append(TopicCellViewModel.init(topic: topic))})
                self?.viewDelegate?.topicsFetched()
            case .failure(let error):
                print(error)
            }
        }
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }
        coordinatorDelegate?.didSelect(topic: topicViewModels[indexPath.row].topic)
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }

    func newTopicWasCreated() {
        topicsDataManager.fetchAllTopics{[weak self] (result) in
            switch result {
            case .success(let lastestTopicsResponse):
                guard let topicsUnw = lastestTopicsResponse?.topicList.topics else {return}
                self?.topicViewModels.removeAll()
                topicsUnw.forEach({topic in
                    print(topic)
                    self?.topicViewModels.append(TopicCellViewModel.init(topic: topic))})
                self?.viewDelegate?.topicsFetched()
            case .failure(let error):
                print(error)
            }
        }
    }
}
