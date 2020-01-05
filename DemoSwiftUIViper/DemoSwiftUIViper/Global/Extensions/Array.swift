import Foundation

extension Array where Array.Element: Identifiable {
    func closeToLastItem<Item: Identifiable>(_ item: Item) -> Bool {
        guard !isEmpty else {
            return false
        }

        guard let itemIndex = firstIndex(where: { $0.id.hashValue == item.id.hashValue }) else {
            return false
        }

        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance <= 5
    }
}
