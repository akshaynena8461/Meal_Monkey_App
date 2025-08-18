import Foundation

class APICalls {
    
    class func getProductData<T: Codable>(
        from urlString: String,
        modelType: T.Type,
        completion: @escaping (_ result: [T]) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: urlRequest) {
            data,
            response,
            error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received")
                completion([])
                return
            }

            do {
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                completion(decodedData)
            } catch {
                print("Decoding error: \(error)")
                completion([])
            }
        }
        task.resume()
    }
}
