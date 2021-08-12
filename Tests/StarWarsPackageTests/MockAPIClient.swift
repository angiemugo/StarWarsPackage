//
//  MockAPIClient.swift
//  StarWarsSDKTests
//
//  Created by Angie Mugo on 04/08/2021.
//

import Foundation
import RxSwift
import RxCocoa
import StarWarsPackage

class MockAPIClient: APIClientProtocol {
    public let localDataSource = JsonLocalDataSource()
    var fetchSuccess = false
    var error: StarWarsError = .timeOut
    var endPoint = APIEndpoint.person
    let disposeBag = DisposeBag()

    func getResponse<T: Decodable>() -> Single<T> {
        switch endPoint {
        case .person:
            return localDataSource.read("Person")
        case .films:
            return localDataSource.read("Films")
        case .planets:
            return localDataSource.read("Planets")
        }
    }

    func request<T: Decodable>(_ urlRequest: URLRequest) -> Single<T> {
        return Single.create { single -> Disposable in
            if self.fetchSuccess {
                self.getResponse().subscribe(onSuccess: { item in
                    single(.success(item))
                }, onFailure: { error in
                    single(.failure(error))
                }).disposed(by: self.disposeBag)
                return Disposables.create()
            } else {
                single(.failure(self.error))
                return Disposables.create()
            }
        }
    }
}
