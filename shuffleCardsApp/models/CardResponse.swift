import Foundation

struct CardResponse: Decodable{
    let deck_id: String
    let cards: [Card]
    
    enum CodingKeys: String, CodingKey{
        case deck_id = "deck_id"
        case cards = "cards"
    }
    
    struct Card: Decodable{
        public var code: String
        public var image : String
    }
    
    
    
}
