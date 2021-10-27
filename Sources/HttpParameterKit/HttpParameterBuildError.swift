import Foundation

public enum HttpParameterBuildError: Error {
	case outOfRange
	case unreachable
	case invalidType
}
