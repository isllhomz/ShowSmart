import Foundation

struct Utility {
    
    static func fetchJson<T:Codable>(_ fileName: String) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
        let data = try? Data(contentsOf: url)
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    static func convertToJSONString<T: Codable>(_ object: T) -> String? {
        do {
            let jsonData = try JSONEncoder().encode(object)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print("Failed to encode modelObject to JSON: \(error)")
            return nil
        }
    }
}
