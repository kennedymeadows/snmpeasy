//
//  FileImportView.swift
//  snmpeasy
//
//  Created by Simon Lewis on 11/28/24.
//
import SwiftUI
import UniformTypeIdentifiers

struct FileImportView: View {
    @State private var selectedFileURL: URL?
    @State private var parsedMIBNodes: [MIBNode] = []

    var body: some View {
        VStack {
            Button("Import MIB File") {
                importMIBFile()
            }
            if let selectedFileURL = selectedFileURL {
                Text("Selected file: \(selectedFileURL.lastPathComponent)")
            }
            OutlineGroup(parsedMIBNodes, children: \.children) { node in
                Text("\(node.name) (\(node.oid))")
            }
        }
    }

    func importMIBFile() {
        let picker = NSOpenPanel()
        picker.title = "Select a MIB File"
        picker.allowedContentTypes = [UTType(filenameExtension: "mib")!, UTType.plainText]
        picker.allowsMultipleSelection = false

        if picker.runModal() == .OK, let url = picker.url {
            selectedFileURL = url
            parseMIBFile(at: url)
        }
    }

    func parseMIBFile(at url: URL) {
        guard let parsedNodes = SNMPCommandBridge.shared.parseMIBFile(url: url) else {
            print("Failed to parse MIB file.")
            return
        }
        parsedMIBNodes = parsedNodes
    }
}
