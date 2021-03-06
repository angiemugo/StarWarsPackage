//
//  JsonLocalDataSource.swift
//  StarWarsSDKTests
//
//  Created by Angie Mugo on 04/08/2021.
//

import Foundation
import RxSwift
import StarWarsPackage

public class JsonLocalDataSource {
    public init() {}

    public func read<T: Decodable>(_ fileName: String) -> Single<T> {
        return Single.create(subscribe: { (observer) -> Disposable in
            if let path = Bundle.styleBundle.path(forResource: fileName, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    if #available(iOS 10.0, *) {
                        decoder.dateDecodingStrategy = .iso8601
                    }
                    observer(.success(try decoder.decode(T.self, from: data)))
                } catch {
                    observer(.failure(error))
                }
            } else {
                observer(.failure(StarWarsError.fileNotFound))
            }
            return Disposables.create()
        })
    }
}

public extension Bundle {
    @objc
    static var styleBundle: Bundle { .module }
}
