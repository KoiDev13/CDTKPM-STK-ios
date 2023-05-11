//
//  APIClient.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/7/23.
//

import Foundation
import Moya

protocol APIClientProtocol {
    associatedtype TargetType: Moya.TargetType

    var provider: MoyaProvider<TargetType> { get }

    func request<T: Decodable>(
        target: TargetType,
        completion: @escaping (Result<T, Error>) -> ()
    )
}

