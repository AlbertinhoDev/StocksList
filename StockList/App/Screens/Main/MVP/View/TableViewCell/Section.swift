enum SectionType {
    case stock
}

enum RowType {
    case stocks
}

struct Section {
    let type: SectionType
    var rows: [RowType]
}
