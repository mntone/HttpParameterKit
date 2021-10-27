import Foundation

protocol HPFloatingPointSupport: HttpParameter {
	associatedtype T: FloatingPoint

	var name: String { get }
	var defaultValue: T { get }
	var minValue: T? { get }
	var maxValue: T? { get }
	var clamped: Bool { get }
	var suppressDefault: Bool { get }

	func dataMsgPack(_ value: T) throws -> Data
}

// MARK: -

extension HPFloatingPointSupport {
	func query(_ value: T?) throws -> String? {
		if let val = value {
			if clamped {
				if let min = minValue, val < min {
					return "\(name.toQuery())=\(min)"
				} else if let max = maxValue, val > max {
					return "\(name.toQuery())=\(max)"
				} else if !suppressDefault || val != defaultValue {
					return "\(name.toQuery())=\(val)"
				} else {
					return nil
				}
			} else {
				if let min = minValue {
					if val < min {
						throw HttpParameterBuildError.outOfRange
					}
				}
				if let max = maxValue {
					if val > max {
						throw HttpParameterBuildError.outOfRange
					}
				}

				if !suppressDefault || val != defaultValue {
					return "\(name.toQuery())=\(val)"
				} else {
					return nil
				}
			}
		} else if !suppressDefault {
			return "\(name.toQuery())=\(defaultValue)"
		} else {
			return nil
		}
	}

	func xml(_ value: T?) throws -> String? {
		if let val = value {
			if clamped {
				if let min = minValue, val < min {
					return "<\(name)>\(min)</\(name)>"
				} else if let max = maxValue, val > max {
					return "<\(name)>\(max)</\(name)>"
				} else if !suppressDefault || val != defaultValue {
					return "<\(name)>\(val)</\(name)>"
				} else {
					return nil
				}
			} else {
				if let min = minValue {
					if val < min {
						throw HttpParameterBuildError.outOfRange
					}
				}
				if let max = maxValue {
					if val > max {
						throw HttpParameterBuildError.outOfRange
					}
				}

				if !suppressDefault || val != defaultValue {
					return "<\(name)>\(val)</\(name)>"
				} else {
					return nil
				}
			}
		} else if !suppressDefault {
			return "<\(name)>\(defaultValue)</\(name)>"
		} else {
			return nil
		}
	}

	func json(_ value: T?) throws -> String? {
		if let val = value {
			if clamped {
				if let min = minValue, val < min {
					return "\"\(name)\":\(min)"
				} else if let max = maxValue, val > max {
					return "\"\(name)\":\(max)"
				} else if !suppressDefault || val != defaultValue {
					return "\"\(name)\":\(val)"
				} else {
					return nil
				}
			} else {
				if let min = minValue {
					if val < min {
						throw HttpParameterBuildError.outOfRange
					}
				}
				if let max = maxValue {
					if val > max {
						throw HttpParameterBuildError.outOfRange
					}
				}

				if !suppressDefault || val != defaultValue {
					return "\"\(name)\":\(val)"
				} else {
					return nil
				}
			}
		} else if !suppressDefault {
			return "\"\(name)\":\(defaultValue)"
		} else {
			return nil
		}
	}

	func msgpack(_ value: T?) throws -> Data? {
		do {
			if let val = value {
				if clamped {
					if let min = minValue, val < min {
						return try dataMsgPack(min)
					} else if let max = maxValue, val > max {
						return try dataMsgPack(max)
					} else if !suppressDefault || val != defaultValue {
						return try dataMsgPack(val)
					} else {
						return nil
					}
				} else {
					if let min = minValue {
						if val < min {
							throw HttpParameterBuildError.outOfRange
						}
					}
					if let max = maxValue {
						if val > max {
							throw HttpParameterBuildError.outOfRange
						}
					}

					if !suppressDefault || val != defaultValue {
						return try dataMsgPack(val)
					} else {
						return nil
					}
				}
			} else if !suppressDefault {
				return try dataMsgPack(defaultValue)
			} else {
				return nil
			}
		} catch {
			throw error
		}
	}
}
