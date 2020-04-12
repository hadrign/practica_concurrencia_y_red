import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Codable {
    let topicList: LastedTopicsList
    
    enum CodingKeys: String, CodingKey {
        case topicList = "topic_list"
    }
}

struct LastedTopicsList: Codable {
    let canCreateTopic: Bool
    let draftKey: String
    let perPage: Int
    let topics: [Topic]
    enum CodingKeys: String, CodingKey {
        case canCreateTopic = "can_create_topic"
        case draftKey = "draft_key"
        case perPage = "per_page"
        case topics
    }
}

struct Topic: Codable {
    let id: Int
    let title: String
    let postsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
    }
}
