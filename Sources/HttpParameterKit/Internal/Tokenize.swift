import Foundation

protocol Tokenize {
	init(text: String)

	mutating func nextToken() -> Token?
}
