import Foundation

struct XmlTextTokenizer: Tokenize {
	private let text: String.UTF8View
	private var iterator: String.UTF8View.Iterator
	private var pushedBackScalar: String.UTF8View.Element?

	init(text: String) {
		self.text = text.utf8
		self.iterator = text.utf8.makeIterator()
	}

	mutating func nextToken() -> Token? {
		while let ch = nextScalar() {
			switch ch {
			case 0x22:
				return .quotationMark
			case 0x26:
				return .ampersand
			case 0x27:
				return .apostrophe
			case 0x3C:
				return .leftThan
			case 0x3E:
				return .rightThan
			default:
				pushedBackScalar = ch
				return stringToken()
			}
		}
		return nil
	}

	private mutating func nextScalar() -> String.UTF8View.Element? {
		if let next = pushedBackScalar {
			pushedBackScalar = nil
			return next
		}
		return iterator.next()
	}

	private mutating func stringToken() -> Token {
		var tokenArray = [UInt8]()
		while let ch = nextScalar() {
			switch ch {
			case 0x22, 0x26, 0x27, 0x3C, 0x3E:
				pushedBackScalar = ch
				return .string(String(bytes: tokenArray, encoding: .utf8)!)
			default:
				tokenArray.append(ch)
			}
		}
		return .string(String(bytes: tokenArray, encoding: .utf8)!)
	}
}
