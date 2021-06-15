import Foundation

@main
struct App {
    
    static func main() {
        detach {
            do {
                // Get Current IP Address
                let ipifyResponse: IpifyResponse = try await fetchAPI(url: IpifyResponse.url)
                print("📗 Resp: \(ipifyResponse)")

                // Get Geolocation data using the IP Address
                let freeGeoIpResponse: FreeGeoIPResponse = try await fetchAPI(url: FreeGeoIPResponse.url(ipAddress: ipifyResponse.ip))
                print("📗 Resp: \(freeGeoIpResponse)")

                // Get Country Detail using the geolocation data country code
                let restCountriesResponse: RestCountriesResponse = try await fetchAPI(url: RestCountriesResponse.url(countryCode: freeGeoIpResponse.countryCode))
                print("📗 Resp: \(restCountriesResponse)")

            } catch {
                print(error.localizedDescription)
            }
        }
        RunLoop.main.run(until: Date.distantFuture)
//        do {
//            let revengeOfSith: SWAPIResponse<Film> = try await fetchAPI(url: Film.url(id: "6"))
//            print("📗 Resp: \(revengeOfSith.response)")
//
//            let urlsFetch = Array(revengeOfSith.response.characterURLs.prefix(upTo: 5))
//            let revengeOfSithCharacters: [SWAPIResponse<People>] = try await fetchAPIGroup(urls: urlsFetch)
//            print("📗 Resp: \(revengeOfSithCharacters)")
//
//        } catch  {
//            print("📕 \(error.localizedDescription)")
//        }
//
    }
}
