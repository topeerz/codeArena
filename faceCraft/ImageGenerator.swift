import Foundation
import UIKit

class ImageGenerator: ObservableObject {
    @Published var isGenerating = false
    @Published var generatedImage: UIImage?
    private let apiKey: String
    
    init() {
        // Get API key from environment
        self.apiKey = Bundle.main.infoDictionary?["OPENAI_API_KEY"] as? String ?? ""
    }

    func generateImage() async throws -> UIImage {
        let url = URL(string: "https://api.openai.com/v1/images/generations")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "prompt": "Create a high-quality anime-style portrait of a cute girl with detailed features, vibrant colors, and expressive eyes. The style should be modern and appealing, suitable for a mobile application.",
            "n": 1,
            "size": "1024x1024",
            "model": "dall-e-3",
            "response_format": "url"
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, httpResponse) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            throw NSError(domain: "ImageGenerator", code: -3, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])
        }
        
        if httpResponse.statusCode != 200 {
            let errorString = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "ImageGenerator", code: httpResponse.statusCode, 
                        userInfo: [NSLocalizedDescriptionKey: "API Error: \(httpResponse.statusCode)\n\(errorString)"])
        }
        
        let apiResponse = try JSONDecoder().decode(ImageGenerationResponse.self, from: data)
        
        guard let imageUrl = URL(string: apiResponse.data[0].url) else {
            throw NSError(domain: "ImageGenerator", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image URL"])
        }
        
        let (imageData, _) = try await URLSession.shared.data(from: imageUrl)
        guard let image = UIImage(data: imageData) else {
            throw NSError(domain: "ImageGenerator", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])
        }
        
        return image
    }
}

struct ImageGenerationResponse: Codable {
    let data: [ImageData]
    
    struct ImageData: Codable {
        let url: String
    }
}
