import Foundation

extension CharacterSet {
	static var queryAllowed: CharacterSet {
		var set = CharacterSet.alphanumerics
		set.insert(charactersIn: "*+-._")
		return set
	}
}
