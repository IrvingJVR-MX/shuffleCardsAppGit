import Foundation


struct DeckReponse : Decodable{
    let success: Bool
    let deck_id: String
    let remaining: Int
    let shuffled : Bool
    
    enum CodingKeys: String, CodingKey{
        case success = "success"
        case deck_id = "deck_id"
        case remaining = "remaining"
        case shuffled = "shuffled"
    }
    
    
    
    
}
