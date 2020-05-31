//
//  Storage.swift
//  
//
//  Created by Oleksandr Stepanov on 31.05.2020.
//

import Foundation

protocol Storage {
    static var sharedInstance: Self { get }
    
    func storedData(with key: String) -> Data?
    func store(data: Data, with key: String)
    func eraseData(with key: String)
}
