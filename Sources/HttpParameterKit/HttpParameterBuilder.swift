import Foundation

@resultBuilder
public struct HttpParameterBuilder {
	public static func buildExpression<T: HttpParameter>(_ element: T) -> [T] {
		[element]
	}

	public static func buildOptional(_ component: [HttpParameter]?) -> [HttpParameter] {
		guard let component = component else { return [] }
		return component
	}

	public static func buildEither(first component: [HttpParameter]) -> [HttpParameter] {
		component
	}

	public static func buildEither(second component: [HttpParameter]) -> [HttpParameter] {
		component
	}

	public static func buildBlock(_ components: [HttpParameter]...) -> [HttpParameter] {
		Array(components.joined())
	}

	public static func buildLimitedAvailability(_ component: [HttpParameter]) -> [HttpParameter] {
		component
	}
}
