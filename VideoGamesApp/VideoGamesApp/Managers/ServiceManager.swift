import Foundation
import Alamofire

final class ServiceManager {
    static let shared = ServiceManager()
  
    private init() { }
    
   /* func getAllGames(completion: @escaping (GameResponse?) -> ()) {
        let url = "https://api.rawg.io/api/games?key=e052e4cee8f8455597212d7b6b8de30a"
        AF.request(url)
            .responseDecodable(of: GameResponse.self) { response in
                switch response.result {
                case .success(let games):
                    print("Başarılı Yanıt: \(games)")
                    completion(games)
                case .failure(let error):
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Başarısız Yanıt: \(utf8Text)")
                    }
                    print("Hata: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }*/
    var gameResponse: GameResponse?
    func getAllGames(completion: @escaping (GameResponse?) -> ()) {
           let url = "https://api.rawg.io/api/games?key=e052e4cee8f8455597212d7b6b8de30a"
           AF.request(url)
               .responseDecodable(of: GameResponse.self) { response in
                   switch response.result {
                   case .success(let games):
                       print("Başarılı Yanıt: \(games)")
                       completion(games)
                   case .failure(let error):
                       if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                           print("Başarısız Yanıt: \(utf8Text)")
                       }
                       print("Hata: \(error.localizedDescription)")
                       completion(nil)
                   }
               }
       }

}
