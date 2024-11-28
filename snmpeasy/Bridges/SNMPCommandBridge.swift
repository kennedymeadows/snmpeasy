//
//  SNMPCommandBridge.swift
//  snmpeasy
//
//  Created by Simon Lewis on 11/28/24.
//
import Foundation

class SNMPCommandBridge {
    static let shared = SNMPCommandBridge()

    func parseMIBFile(url: URL) -> [MIBNode]? {
        let command = "/usr/bin/snmptranslate -Tp -m \(url.path)"

        guard let output = runCommand(command) else {
            return nil
        }
        return SNMPParser.parseSNMPTranslate(output)
    }

    private func runCommand(_ command: String) -> String? {
        let task = Process()
        task.launchPath = "/bin/zsh"
        task.arguments = ["-c", command]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)
    }
}
