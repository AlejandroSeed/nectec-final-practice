//
//  ATSTvShowManager.swift
//  AlexTVShows
//
//  Created by Alejandro Orihuela Becerril on 02/07/23.
//

import Foundation
import CoreData

final class ATSTvShowManager {
    enum ManagerError: Error {
        case badURL
        case bd
        case unknow
        case existingItem
    }
    
    func getTvShow(country: ATSCountry = .us, date: Date = Date(), completion: @escaping (Result<[ATSTvShow], Error>) -> Void) {
        do {
            guard let formattedDate = date.toServiceFormatt() else {
                throw Self.ManagerError.unknow
            }
            
            guard let url = URL(string: "https://api.tvmaze.com/schedule?country=\(country.rawValue)&date=\(formattedDate)") else {
                throw Self.ManagerError.badURL
            }
            
            var urlRequest = URLRequest(url: url)
            
            urlRequest.httpMethod = "GET"
            urlRequest.timeoutInterval = 20
            
            URLSession(configuration: .ephemeral).dataTask(with: urlRequest) { data, response, error in
                do {
                    if let error = error {
                        throw error
                    }
                    
                    guard let data = data else {
                        throw Self.ManagerError.unknow
                    }
                    
                    let tvShows = try JSONDecoder().decode([ATSTvShow].self, from: data)
                    
                    completion(.success(tvShows))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveFavoriteTvShow(tvShow: ATSTvShow, context: NSManagedObjectContext) throws {
        guard try findTvShow(tvShow: tvShow, context: context) == nil else {
            throw Self.ManagerError.existingItem
        }
        
        guard let id = tvShow.id,
              let name = tvShow.name else {
            throw Self.ManagerError.bd
        }
        
        let cdTvShow = TvShow(context: context)
        
        cdTvShow.id = Int64(id)
        cdTvShow.name = name
        
        if let rating = tvShow.rating?.average {
            cdTvShow.rating = NSDecimalNumber(value: rating)
        }
        
        if let image = tvShow.image?.medium {
            cdTvShow.image = URL(string: image)
        }
        
        cdTvShow.summary = tvShow.summary
        
        try context.save()
    }
    
    func getFavoriteTvShows(context: NSManagedObjectContext) throws -> [ATSTvShow] {
        try getFavoriteTvShowsFromCD(context: context).map { $0.toATSTvShow() }
    }
    
    func deleteFavoriteTvShow(tvShow: ATSTvShow, context: NSManagedObjectContext) throws {
        guard let tvShowToDelete = try findTvShow(tvShow: tvShow, context: context) else {
            return
        }
        
        context.delete(tvShowToDelete)
        
        try context.save()
    }
}

//MARK: - Private functions
extension ATSTvShowManager {
    private func findTvShow(tvShow: ATSTvShow, context: NSManagedObjectContext) throws -> TvShow? {
        let favoriteTvShows: [TvShow] = try getFavoriteTvShowsFromCD(context: context)
        
        return favoriteTvShows.first(where: {  $0.id == tvShow.id ?? -1 })
    }
    
    private func getFavoriteTvShowsFromCD(context: NSManagedObjectContext) throws -> [TvShow] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TvShow")
        
        request.returnsObjectsAsFaults = false
        
        let result = try context.fetch(request)
        
        guard let tvShows = result as? [TvShow] else {
            throw Self.ManagerError.bd
        }
        
        return tvShows
    }
}
