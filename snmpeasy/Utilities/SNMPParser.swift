//
//  SNMPParser.swift
//  snmpeasy
//
//  Created by Simon Lewis on 11/28/24.
//
import Foundation

class SNMPParser {
    static func parseSNMPTranslate(_ output: String) -> [MIBNode] {
        var nodes: [MIBNode] = []
        var parentStack: [MIBNode] = []

        let lines = output.split(separator: "\n")

        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)

            guard trimmedLine.contains("+--") else {
                continue
            }

            let pattern = #"\+--([^\(]+)\((\d+)\)"#
            let regex = try! NSRegularExpression(pattern: pattern)
            if let match = regex.firstMatch(in: trimmedLine, range: NSRange(trimmedLine.startIndex..., in: trimmedLine)) {
                let name = String(trimmedLine[Range(match.range(at: 1), in: trimmedLine)!]).trimmingCharacters(in: .whitespaces)
                let oid = String(trimmedLine[Range(match.range(at: 2), in: trimmedLine)!])

                let node = MIBNode(name: name, oid: oid, children: [])

                let indentLevel = line.prefix { $0 == " " }.count
                while let lastParent = parentStack.last, lastParent.name.count * 2 >= indentLevel {
                    _ = parentStack.popLast()
                }

                if let parent = parentStack.last {
                    var updatedParent = parent
                    updatedParent.children = (updatedParent.children ?? []) + [node]
                    nodes[nodes.count - 1] = updatedParent
                } else {
                    nodes.append(node)
                }

                parentStack.append(node)
            }
        }

        print("Parsed Nodes: \(nodes)")
        return nodes
    }
}



