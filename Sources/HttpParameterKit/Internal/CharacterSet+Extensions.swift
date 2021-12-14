import Foundation

extension CharacterSet {
	static var queryAllowed: CharacterSet {
		var set = CharacterSet.alphanumerics
		set.insert(charactersIn: "+-._~")
		return set
	}

	static var rfc1738safe: CharacterSet {
		var set = CharacterSet.alphanumerics
		set.insert(charactersIn: "$+-._")
		return set
	}

	static var rfc1738: CharacterSet {
		var set = CharacterSet.alphanumerics
		set.insert(charactersIn: "!$'()*+,-._~")
		return set
	}

	static var rfc2396: CharacterSet {
		var set = CharacterSet.alphanumerics
		set.insert(charactersIn: "!'()*-._~")
		return set
	}

	static var rfc3986: CharacterSet {
		var set = CharacterSet.alphanumerics
		set.insert(charactersIn: "-._~")
		return set
	}
}
