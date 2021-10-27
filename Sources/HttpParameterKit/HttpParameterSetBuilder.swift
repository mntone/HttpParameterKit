import Foundation

@resultBuilder
public struct HttpParameterSetBuilder {
	public static func buildExpression(_ element: HPSet) -> [HPSet] {
		[element]
	}

	public static func buildOptional(_ component: [HPSet]?) -> [HPSet] {
		guard let component = component else { return [] }
		return component
	}

	public static func buildEither(first component: [HPSet]) -> [HPSet] {
		component
	}

	public static func buildEither(second component: [HPSet]) -> [HPSet] {
		component
	}

	public static func buildBlock(_ components: [HPSet]...) -> [HPSet] {
		Array(components.joined())
	}

	public static func buildLimitedAvailability(_ component: [HPSet]) -> [HPSet] {
		component
	}
}
