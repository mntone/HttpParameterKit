import Foundation

struct JsonTextTokenizer: Tokenize {
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
			case 0x08:
				return .backspace
			case 0x09:
				return .tab
			case 0x0A:
				return .lineFeed
			case 0x0C:
				return .formFeed
			case 0x0D:
				return .carriageReturn
			case 0x22:
				return .quotationMark
			case 0x5C:
				return .reverseSolidus
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
			case 0x08, 0x09, 0x0A, 0x0C, 0x0D, 0x22, 0x2F, 0x5C:
				pushedBackScalar = ch
				return .string(String(bytes: tokenArray, encoding: .utf8)!)
			default:
				tokenArray.append(ch)
			}
		}
		return .string(String(bytes: tokenArray, encoding: .utf8)!)
	}
}
