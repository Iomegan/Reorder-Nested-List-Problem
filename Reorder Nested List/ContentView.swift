//
//  ContentView.swift
//  Reorder Nested List
//
//  Created by Daniel Witt on 04.11.2023.
//

import CoreTransferable
import SwiftUI
import UniformTypeIdentifiers.UTType

struct ContentView: View {
    var body: some View {
        ItemView(fileItem: FileItem(name: "Dragging this from outside the list works on all plattforms!"))

        List {
            OutlineGroup(data, children: \.children) { item in
                ItemView(fileItem: item)
                    .id(item)
                    .tag(item)
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct ItemView: View {
    let fileItem: FileItem
    var body: some View {
        let dropDelegate = ExampleDropDelegat()
        Text("\(fileItem.description)")
            .draggable(fileItem.name)
            .onDrop(of: [.plainText], delegate: dropDelegate)
    }
}

class ExampleDropDelegat: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        print("It works! - but only on macOS :(")
        return true
    }
}

struct FileItem: Hashable, Identifiable, CustomStringConvertible, Transferable {
    var id: Self { self }
    var name: String
    var children: [FileItem]? = nil
    var description: String {
        switch children {
            case nil:
                return "📄 \(name)"
            case .some(let children):
                return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
        }
    }

    public static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation { item in
            item.name
        }
    }
}

let data =
    FileItem(name: "users", children:
        [FileItem(name: "user1234", children:
            [FileItem(name: "Photos", children:
                [FileItem(name: "photo001.jpg"),
                 FileItem(name: "photo002.jpg")]),
            FileItem(name: "Movies", children:
                [FileItem(name: "movie001.mp4")]),
            FileItem(name: "Documents", children: [])]),
        FileItem(name: "newuser", children:
            [FileItem(name: "Documents", children: [])])])
