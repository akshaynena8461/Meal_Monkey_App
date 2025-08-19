import Foundation

class APICalls {
    
    /// Generic function to fetch product data from an API endpoint.
    /// - Parameters:
    ///   - urlString: The URL string of the API endpoint.
    ///   - modelType: The Codable type to decode the JSON into.
    ///   - completion: Completion handler returning an array of decoded objects.
    class func getProductData<T: Codable>(
        from urlString: String,
        modelType: T.Type,
        completion: @escaping (_ result: [T]) -> Void
    ) {
        // Ensure the URL string is valid
        guard let url = URL(string: urlString) else {
            completion([]) // Return empty array if URL is invalid
            return
        }
        
        // Create a URLRequest object with GET method
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        // Start the data task
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            // Handle errors from URLSession
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion([]) // Return empty array on error
                return
            }

            // Ensure we received data
            guard let data = data else {
                print("No data received")
                completion([]) // Return empty array if no data
                return
            }

            do {
                // Decode the JSON data into an array of type T
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                completion(decodedData) // Return decoded array
            } catch {
                print("Decoding error: \(error)")
                completion([]) // Return empty array if decoding fails
            }
        }

        // Start the network request
        task.resume()
    }
}
