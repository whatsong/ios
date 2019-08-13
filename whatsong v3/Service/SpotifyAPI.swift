//
//  SpotifyAPI.swift
//  whatsong v3
//
//  Created by Developer iOS on 02/08/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

class SpotifyAPI {
    static let sharedSpotifyAPI = SpotifyAPI()
    func getCurrentSpotifyUserInfo(completion: @escaping(SpotifyUserData?, _ success: Bool) -> ()) {
        if  APP_DELEGATE.session != nil {
            let token = APP_DELEGATE.session.accessToken
            var request = URLRequest(url:URL(string:"https://api.spotify.com/v1/me")!)
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            //http get
            URLSession.shared.dataTask(with: request){ data, response, error in
                guard(error == nil) else {
                    completion(nil, false)
                    return
                }
                do {
                    if let returnData = String(data: data!, encoding: .utf8) {
                        print("OUTPUT in String : \(returnData)");
                    }
                    let parseResult = try JSONDecoder().decode(SpotifyUserData.self, from: data!)
                    completion(parseResult, true)
                } catch {
                    completion(nil, false)
                }
                }.resume()
        } else {
            let error: Error = NSLocalizedString("accessToken invalid", comment: "") as! Error
            
            completion(nil, false)
        }
    }
    func getCurrentSpotifyUserPlaylist(completion: @escaping(SpotifyUserPlaylist?, _ success: Bool) -> ()) {
        if  APP_DELEGATE.session != nil {
            let token = APP_DELEGATE.session.accessToken
            var request = URLRequest(url:URL(string:"https://api.spotify.com/v1/me/playlists")!)
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            //http get
            URLSession.shared.dataTask(with: request){ data, response, error in
                guard(error == nil) else {
                    completion(nil, false)
                    return
                }
                do {
                    if let returnData = String(data: data!, encoding: .utf8) {
                        print("OUTPUT in String : \(returnData)");
                    }
                    let parseResult = try JSONDecoder().decode(SpotifyUserPlaylist.self, from: data!)
                    completion(parseResult, true)
                } catch {
                    completion(nil, false)
                }
                }.resume()
        } else {
            let error: Error = NSLocalizedString("accessToken invalid", comment: "") as! Error
            
            completion(nil, false)
        }
    }
    func createAPlaylist(name: String!, completion: @escaping (_ result: Bool, _ playlistId: String) -> Void) {
        
        var request = URLRequest(url:URL(string:"https://api.spotify.com/v1/users/\(DAKeychain.shared["SpotifyUserId"]!)/playlists")!)
        let token = APP_DELEGATE.session.accessToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "name" : name,
            "public" : false
        ]
        do {
         let jsonDictData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        request.httpBody = jsonDictData
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard(error == nil) else {
                completion(false, "")
                return
            }
            if let data = data {
                do {
                    if let returnData = String(data: data, encoding: .utf8) {
                        print("OUTPUT in String : \(returnData)");
                    }
                    let parseResult = try JSONDecoder().decode(CreatePlayListSpotifyModel.self, from: data)
                    print(parseResult)
                    completion(true, parseResult.id)
                } catch {
                    completion( false, "")
                }
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                completion(true, "")
                
            } else {
                completion(false, "")
            }
            
            }.resume()
        }
        catch{
            
        }
        
    }
    func addSoongToPlayList(playlist_id: String!,uris: String!, completion: @escaping (_ result: Bool) -> Void) {
        
        var request = URLRequest(url:URL(string:"https://api.spotify.com/v1/playlists/\(playlist_id!)/tracks?uris=\(uris!)")!)
        let token = APP_DELEGATE.session.accessToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [:]
        do {
            let jsonDictData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonDictData
            URLSession.shared.dataTask(with: request){ data, response, error in
                guard(error == nil) else {
                    completion(false)
                    return
                }
                if let data = data {
                    do {
                        if let returnData = String(data: data, encoding: .utf8) {
                            print("OUTPUT in String : \(returnData)");
                        }
                        let parseResult = try JSONDecoder().decode(SignUpResponse.self, from: data)
                        print(parseResult)
                        if parseResult.success {
                            completion(true)
                        } else {
                            completion( false)
                        }
                        
                    } catch {
                        completion( false)
                    }
                }
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    completion(true)
                    
                } else {
                    completion(false)
                }
                
                }.resume()
        }
        catch{
            
        }
        
    }
}
