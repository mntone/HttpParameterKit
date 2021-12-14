import Foundation

public struct _QueryUtil {
	public enum Encoding: String, Hashable {
		case `default`
		case rfc1738safe
		case rfc1738
		case rfc2396
		case rfc3986
	}

	public static func query(as str: String, encoding: Encoding = .default) -> String {
		switch encoding {
		case .default:
			return str.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
				.addingPercentEncoding(withAllowedCharacters: .queryAllowed)!
		case .rfc1738safe:
			return str.addingPercentEncoding(withAllowedCharacters: .rfc1738safe)!
		case .rfc1738:
			return str.addingPercentEncoding(withAllowedCharacters: .rfc1738)!
		case .rfc2396:
			return str.addingPercentEncoding(withAllowedCharacters: .rfc2396)!
		case .rfc3986:
			return str.addingPercentEncoding(withAllowedCharacters: .rfc3986)!
		}
	}
}
