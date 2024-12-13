func fetchData() async throws -> Data {
    let url = URL(string: "https://api.example.com/data")!
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: "Server returned error code: \(httpResponse?.statusCode ?? -1)"])
    }

    return data
}

Task { 
    do {
        let data = try await fetchData()
        // Process data
    } catch let error as URLError {
        print("Network error: \(error.localizedDescription)")
        // Handle network error gracefully (e.g., show an alert, retry the request)
    } catch {
        print("An unexpected error occurred: \(error)")
        // Handle other errors
    }
}