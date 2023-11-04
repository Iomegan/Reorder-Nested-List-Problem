#  Reorder Nested List SwiftUI Problem

## How to implement reordering of nested lists using OutlineGroup in SwiftUI?

 .onMove() is only avaialble for simple forEach lists so one has to implement custom code. It works on macOS using custom drag and drop, however on iOS and iPadOS the DropDelegate is never being called. I've tried all kinds of combinations but it always fails on iOS and iPadOS. It looks like if a view cannot accapt a drop from the same type of view. At least not in this combination with List and OutlineGroup.
