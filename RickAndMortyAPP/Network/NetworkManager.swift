//
//  NetworkManager.swift
//  RickAndMortyAPP
//
//  Created by bora ateş on 14.06.2022.
//

import Alamofire
import AlamofireMapper

class NetworkManager {
    
    private var baseApiUrl = Bundle.main.object(forInfoDictionaryKey: "ApiUrl") as! String

    var isPaginating: Bool = false
    
    //MARK:- getCharacterList
    public func getCharacterList(pagination: Bool = false, page: String, successCompletion: @escaping ((_ response : CharacterResponse) -> Void)) {
        
        if pagination {
            isPaginating = true
        }
        
        let url = baseApiUrl + "/character?page="+page
        print("Url request:"+url)
        Alamofire.request(url, method: .get, parameters: nil).responseObject { (response : DataResponse<CharacterResponse>) in
            switch response.result {
            case .success(let json):
                successCompletion(json)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
            if pagination {
                self.isPaginating = false
            }
        }
    }
    
    //MARK:- getCharacterWithID
    public func getCharacterWithID(id: String, successCompletion: @escaping ((_ response : Result) -> Void)) {
       
        let urlString = baseApiUrl + "/character/"+id
        let session = URLSession.shared
        let url = URL(string: urlString)!

        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else { return print("Server error!") }

            guard let mime = response.mimeType, mime == "application/json" else { return print("Wrong MIME type!") }

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
                
                if let decodedResponse = try? JSONDecoder().decode(Result.self, from: data!) {
                    print(decodedResponse)
                    DispatchQueue.main.async {
                        successCompletion(decodedResponse)
                    }
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
    
}


