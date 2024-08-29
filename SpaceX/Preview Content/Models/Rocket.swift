import SwiftUI

struct Rocket: Hashable, Decodable, Identifiable  {
    static func == (lhs: Rocket, rhs: Rocket) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    let name: String
    let description: String
    var imageURL: String?
    var isFavorite: Bool
    let height: Dimension?
    let diameter: Dimension?
    let mass: Mass?
    let flickr_images: [String]?
    let payload_weights: [Payload]?
    
    func hash(into hasher: inout Hasher) {
          hasher.combine(id)
      }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case height
        case diameter
        case mass
        case flickr_images
        case payload_weights
    }
    

    
    init(id: String, name: String, description: String, imageURL: String?, isFavorite: Bool, height: Dimension?, diameter: Dimension?, mass: Mass?, flickr_images: [String]?, payload_weights: [Payload]?) {
        self.id = id
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.isFavorite = isFavorite
        self.height = height
        self.diameter = diameter
        self.mass = mass
        self.flickr_images = flickr_images
        self.payload_weights = payload_weights
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        height = try? container.decode(Dimension.self, forKey: .height)
        diameter = try? container.decode(Dimension.self, forKey: .diameter)
        mass = try? container.decode(Mass.self, forKey: .mass)
        flickr_images = try? container.decode([String].self, forKey: .flickr_images)
        payload_weights = try? container.decode([Payload].self, forKey: .payload_weights)
        imageURL = flickr_images?.first
        isFavorite = false
    }
    
    mutating func toggleFavorite() {
        self.isFavorite.toggle()
    }
}

struct Mass: Codable, Hashable {
    let kg: Double?
    let lb: Double?
    
    init(kg: Double? = nil, lb: Double? = nil) {
        self.kg = kg
        self.lb = lb
    }
}

struct Dimension: Codable, Hashable {
    let meters: Double?
    let feet: Double?
    
    init(meters: Double? = nil, feet: Double? = nil) {
        self.meters = meters
        self.feet = feet
    }
}

struct Payload: Codable, Hashable {
    var id: String?
    var name: String?
    var kg: Double?
    var lb: Double?
    
    init(id: String? = nil, name: String? = nil, kg: Double? = nil, lb: Double? = nil) {
        self.id = id
        self.name = name
        self.kg = kg
        self.lb = lb
    }
}
