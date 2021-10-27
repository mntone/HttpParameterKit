import Foundation

enum Token {
	case backspace
	case tab
	case lineFeed
	case formFeed
	case carriageReturn
	case quotationMark
	case ampersand
	case apostrophe
	case leftThan
	case rightThan
	case reverseSolidus

	case string(String)
}
