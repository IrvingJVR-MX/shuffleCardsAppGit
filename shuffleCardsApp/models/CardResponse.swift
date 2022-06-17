import Foundation

struct CardResponse: Decodable{
    let deck_id: String
    let cards: [CardProperties]
    
    enum CodingKeys: String, CodingKey{
        case deck_id = "deck_id"
        case cards = "cards"
    }
        
    
}
