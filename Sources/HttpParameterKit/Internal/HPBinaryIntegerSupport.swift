import Foundation

protocol HPBinaryIntegerSupport: HttpParameter {
	associatedtype T: BinaryInteger

	var name: String { get }
	var defaultValue: T { get }
	var minValue: T? { get }
	var maxValue: T? { get }
	var clamped: Bool { get }
	var suppressDefault: Bool { get }

	func dataMsgPack(_ value: T) throws -> Data
}

// MARK: -

extension HPBinaryIntegerSupport {
	@inlinable
	func query(_ value: T?, encoding: QueryEncoding) throws -> String? {
		if let val = value {
			if clamped {
				if let min = minValue, val < min {
					let _name: String = _QueryUtil.query(from: name, encoding: encoding)
					return "\(_name)=\(min)"
				} else if let max = maxValue, val > max {
					let _name: String = _QueryUtil.query(from: name, encoding: encoding)
					return "\(_name)=\(max)"
				} else if !suppressDefault || val != defaultValue {
					let _name: String = _QueryUtil.query(from: name, encoding: encoding)
					return "\(_name)=\(val)"
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
					let _name: String = _QueryUtil.query(from: name, encoding: encoding)
					return "\(_name)=\(val)"
				} else {
					return nil
				}
			}
		} else if !suppressDefault {
			let _name: String = _QueryUtil.query(from: name, encoding: encoding)
			return "\(_name)=\(defaultValue)"
		} else {
			return nil
		}
	}

	@inlinable
	func querydata(_ value: T?, encoding: QueryEncoding) throws -> HPPair? {
		if let val = value {
			if clamped {
				if let min = minValue, val < min {
					let _name: String = _QueryUtil.query(from: name, encoding: encoding)
					return (_name, String(min))
				} else if let max = maxValue, val > max {
					let _name: String = _QueryUtil.query(from: name, encoding: encoding)
					return (_name, String(max))
				} else if !suppressDefault || val != defaultValue {
					let _name: String = _QueryUtil.query(from: name, encoding: encoding)
					return (_name, String(val))
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
					let _name: String = _QueryUtil.query(from: name, encoding: encoding)
					return (_name, String(val))
				} else {
					return nil
				}
			}
		} else if !suppressDefault {
			let _name: String = _QueryUtil.query(from: name, encoding: encoding)
			return (_name, String(defaultValue))
		} else {
			return nil
		}
	}

	@inlinable
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

	@inlinable
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
