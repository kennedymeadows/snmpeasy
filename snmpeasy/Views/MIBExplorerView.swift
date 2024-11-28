//
//  MIBExplorerView.swift
//  snmpeasy
//
//  Created by Simon Lewis on 11/28/24.
//
import SwiftUI
import UniformTypeIdentifiers

struct MIBExplorerView: View {
    @State private var mibTree: [MIBNode] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if mibTree.isEmpty {
                    Text("No data loaded. Click 'Import MIB File' to begin.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    OutlineGroup(mibTree, children: \.children) { node in
                        NavigationLink(destination: OIDDetailView(oid: node)) {
                            HStack {
                                Text(node.name)
                                Spacer()
                                Text("(\(node.oid))").foregroundColor(.gray)
                            }
                        }
                        .padding(4)
                    }
                }
            }
            .navigationTitle("MIB Explorer")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        loadMIBTree()
                    }) {
                        Label("Import MIB File", systemImage: "folder")
                    }
                }
            }
        }
    }
    
    func loadMIBTree() {
        let panel = NSOpenPanel()
        panel.title = "Select a MIB File"
        panel.allowedContentTypes = [UTType(filenameExtension: "mib")!, UTType.plainText]
        panel.allowsMultipleSelection = false

        if panel.runModal() == .OK, let url = panel.url {
            print("Selected MIB file: \(url.path)")
            if let parsedTree = SNMPCommandBridge.shared.parseMIBFile(url: url) {
                print("MIB Tree parsed successfully with \(parsedTree.count) top-level nodes.")
                mibTree = parsedTree
            } else {
                print("Failed to parse MIB file.")
            }
        } else {
            print("No file selected.")
        }
    }
}
