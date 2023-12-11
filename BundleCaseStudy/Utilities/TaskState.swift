//
//  TaskState.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Foundation

enum TaskState<T: Error> {

    case loading
    case success
    case failure(error: T)
}
