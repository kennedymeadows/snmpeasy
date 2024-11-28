//
//  OIDDetailView.swift
//  snmpeasy
//
//  Created by Simon Lewis on 11/28/24.
//
import SwiftUI

struct OIDDetailView: View {
    var oid: MIBNode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("OID Details")
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                Text("Name:")
                    .fontWeight(.semibold)
                Spacer()
                Text(oid.name)
            }
            
            HStack {
                Text("OID:")
                    .fontWeight(.semibold)
                Spacer()
                Text(oid.oid)
            }
            
            if let description = oid.description {
                Text("Description:")
                    .fontWeight(.semibold)
                Text(description)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Details for \(oid.name)")
    }
}


