import Foundation

extension String {
	func toQuery() -> String {
		replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
			.addingPercentEncoding(withAllowedCharacters: .queryAllowed)!
	}
}
