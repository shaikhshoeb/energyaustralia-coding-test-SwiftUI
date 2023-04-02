//
//  APIService.swift
//  InfyTest
//
//  Created by Shoeb on 01/04/23.
//

import Foundation

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}
