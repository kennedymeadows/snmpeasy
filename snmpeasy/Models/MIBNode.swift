//
//  MIBNode.swift
//  snmpeasy
//
//  Created by Simon Lewis on 11/28/24.
//
import Foundation

struct MIBNode: Identifiable {
    let id = UUID()
    let name: String
    let oid: String
    var description: String? 
    var children: [MIBNode]?
}
