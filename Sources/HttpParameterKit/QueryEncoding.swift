import Foundation

public enum QueryEncoding: String, Hashable {
	case `default`
	case rfc1738safe
	case rfc1738
	case rfc2396
	case rfc3986
}
