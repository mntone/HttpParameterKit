import Foundation

public struct HPSet: HttpParameter {
	private let parameters: [HttpParameter]
	private let optionals: [HttpParameter]

	public init(@HttpParameterBuilder parameters: () -> [HttpParameter]) {
		self.parameters = parameters()
		self.optionals = []
	}

	public init(@HttpParameterBuilder parameters: () -> [HttpParameter],
				@HttpParameterBuilder optionals: () -> [HttpParameter]) {
		self.parameters = parameters()
		self.optionals = optionals()
	}

	func validateSet(_ value: [String: AnyHashable]) -> Bool {
		parameters.allSatisfy { p in
			let parameter = p as! HttpParameterInternal
			return value[parameter.name] != nil
		}
	}
}

extension HPSet {
	func query(_ value: [String: AnyHashable], encoding: _QueryUtil.Encoding) throws -> [String] {
		do {
			return try (parameters + optionals).compactMap { item in
				switch item {
				case let nilItem as HPNil:
					return try nilItem.query((), encoding: encoding)
				case let boolItem as HPBool:
					return try boolItem.query(value[boolItem.name] as? Bool, encoding: encoding)
				case let stringItem as HPString:
					return try stringItem.query(value[stringItem.name] as? String, encoding: encoding)
				case let integerItem as HPInt:
					return try integerItem.query(value[integerItem.name] as? Int, encoding: encoding)
				case let int8Item as HPInt8:
					return try int8Item.query(value[int8Item.name] as? Int8, encoding: encoding)
				case let int16Item as HPInt16:
					return try int16Item.query(value[int16Item.name] as? Int16, encoding: encoding)
				case let int32Item as HPInt32:
					return try int32Item.query(value[int32Item.name] as? Int32, encoding: encoding)
				case let int64Item as HPInt64:
					return try int64Item.query(value[int64Item.name] as? Int64, encoding: encoding)
				case let uintItem as HPUInt:
					return try uintItem.query(value[uintItem.name] as? UInt, encoding: encoding)
				case let uint8Item as HPUInt8:
					return try uint8Item.query(value[uint8Item.name] as? UInt8, encoding: encoding)
				case let uint16Item as HPUInt16:
					return try uint16Item.query(value[uint16Item.name] as? UInt16, encoding: encoding)
				case let uint32Item as HPUInt32:
					return try uint32Item.query(value[uint32Item.name] as? UInt32, encoding: encoding)
				case let uint64Item as HPUInt64:
					return try uint64Item.query(value[uint64Item.name] as? UInt64, encoding: encoding)
				case let floatItem as HPFloat:
					return try floatItem.query(value[floatItem.name] as? Float, encoding: encoding)
				case let doubleItem as HPDouble:
					return try doubleItem.query(value[doubleItem.name] as? Double, encoding: encoding)
				default:
#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))
					if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *),
					   let float16Item = item as? HPFloat16 {
						return try float16Item.query(value[float16Item.name] as? Float16, encoding: encoding)
					}
#endif
#if swift(>=1.1) && os(macOS)
					if #available(macOS 10.10, *),
					   let float80Item = item as? HPFloat80 {
						return try float80Item.query(value[float80Item.name] as? Float80, encoding: encoding)
					}
#endif
					throw HttpParameterBuildError.invalidType
				}
			}
		} catch {
			throw error
		}
	}

	func xml(_ value: [String: AnyHashable]) throws -> [String] {
		do {
			return try (parameters + optionals).compactMap { item in
				switch item {
				case let nilItem as HPNil:
					return try nilItem.xml(())
				case let boolItem as HPBool:
					return try boolItem.xml(value[boolItem.name] as? Bool)
				case let stringItem as HPString:
					return try stringItem.xml(value[stringItem.name] as? String)
				case let integerItem as HPInt:
					return try integerItem.xml(value[integerItem.name] as? Int)
				case let int8Item as HPInt8:
					return try int8Item.xml(value[int8Item.name] as? Int8)
				case let int16Item as HPInt16:
					return try int16Item.xml(value[int16Item.name] as? Int16)
				case let int32Item as HPInt32:
					return try int32Item.xml(value[int32Item.name] as? Int32)
				case let int64Item as HPInt64:
					return try int64Item.xml(value[int64Item.name] as? Int64)
				case let uintItem as HPUInt:
					return try uintItem.xml(value[uintItem.name] as? UInt)
				case let uint8Item as HPUInt8:
					return try uint8Item.xml(value[uint8Item.name] as? UInt8)
				case let uint16Item as HPUInt16:
					return try uint16Item.xml(value[uint16Item.name] as? UInt16)
				case let uint32Item as HPUInt32:
					return try uint32Item.xml(value[uint32Item.name] as? UInt32)
				case let uint64Item as HPUInt64:
					return try uint64Item.xml(value[uint64Item.name] as? UInt64)
				case let floatItem as HPFloat:
					return try floatItem.xml(value[floatItem.name] as? Float)
				case let doubleItem as HPDouble:
					return try doubleItem.xml(value[doubleItem.name] as? Double)
				default:
#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))
					if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *),
					   let float16Item = item as? HPFloat16 {
						return try float16Item.xml(value[float16Item.name] as? Float16)
					}
#endif
#if swift(>=1.1) && os(macOS)
					if #available(macOS 10.10, *),
					   let float80Item = item as? HPFloat80 {
						return try float80Item.xml(value[float80Item.name] as? Float80)
					}
#endif
					throw HttpParameterBuildError.invalidType
				}
			}
		} catch {
			throw error
		}
	}

	func json(_ value: [String: AnyHashable]) throws -> [String] {
		do {
			return try (parameters + optionals).compactMap { item in
				switch item {
				case let nilItem as HPNil:
					return try nilItem.json(())
				case let boolItem as HPBool:
					return try boolItem.json(value[boolItem.name] as? Bool)
				case let stringItem as HPString:
					return try stringItem.json(value[stringItem.name] as? String)
				case let integerItem as HPInt:
					return try integerItem.json(value[integerItem.name] as? Int)
				case let int8Item as HPInt8:
					return try int8Item.json(value[int8Item.name] as? Int8)
				case let int16Item as HPInt16:
					return try int16Item.json(value[int16Item.name] as? Int16)
				case let int32Item as HPInt32:
					return try int32Item.json(value[int32Item.name] as? Int32)
				case let int64Item as HPInt64:
					return try int64Item.json(value[int64Item.name] as? Int64)
				case let uintItem as HPUInt:
					return try uintItem.json(value[uintItem.name] as? UInt)
				case let uint8Item as HPUInt8:
					return try uint8Item.json(value[uint8Item.name] as? UInt8)
				case let uint16Item as HPUInt16:
					return try uint16Item.json(value[uint16Item.name] as? UInt16)
				case let uint32Item as HPUInt32:
					return try uint32Item.json(value[uint32Item.name] as? UInt32)
				case let uint64Item as HPUInt64:
					return try uint64Item.json(value[uint64Item.name] as? UInt64)
				case let floatItem as HPFloat:
					return try floatItem.json(value[floatItem.name] as? Float)
				case let doubleItem as HPDouble:
					return try doubleItem.json(value[doubleItem.name] as? Double)
				default:
#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))
					if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *),
					   let float16Item = item as? HPFloat16 {
						return try float16Item.json(value[float16Item.name] as? Float16)
					}
#endif
#if swift(>=1.1) && os(macOS)
					if #available(macOS 10.10, *),
					   let float80Item = item as? HPFloat80 {
						return try float80Item.json(value[float80Item.name] as? Float80)
					}
#endif
					throw HttpParameterBuildError.invalidType
				}
			}
		} catch {
			throw error
		}
	}

	func msgpack(_ value: [String: AnyHashable]) throws -> [Data] {
		do {
			return try (parameters + optionals).compactMap { item in
				switch item {
				case let nilItem as HPNil:
					return try nilItem.msgpack(())
				case let boolItem as HPBool:
					return try boolItem.msgpack(value[boolItem.name] as? Bool)
				case let stringItem as HPString:
					return try stringItem.msgpack(value[stringItem.name] as? String)
				case let integerItem as HPInt:
					return try integerItem.msgpack(value[integerItem.name] as? Int)
				case let int8Item as HPInt8:
					return try int8Item.msgpack(value[int8Item.name] as? Int8)
				case let int16Item as HPInt16:
					return try int16Item.msgpack(value[int16Item.name] as? Int16)
				case let int32Item as HPInt32:
					return try int32Item.msgpack(value[int32Item.name] as? Int32)
				case let int64Item as HPInt64:
					return try int64Item.msgpack(value[int64Item.name] as? Int64)
				case let uintItem as HPUInt:
					return try uintItem.msgpack(value[uintItem.name] as? UInt)
				case let uint8Item as HPUInt8:
					return try uint8Item.msgpack(value[uint8Item.name] as? UInt8)
				case let uint16Item as HPUInt16:
					return try uint16Item.msgpack(value[uint16Item.name] as? UInt16)
				case let uint32Item as HPUInt32:
					return try uint32Item.msgpack(value[uint32Item.name] as? UInt32)
				case let uint64Item as HPUInt64:
					return try uint64Item.msgpack(value[uint64Item.name] as? UInt64)
				case let floatItem as HPFloat:
					return try floatItem.msgpack(value[floatItem.name] as? Float)
				case let doubleItem as HPDouble:
					return try doubleItem.msgpack(value[doubleItem.name] as? Double)
				default:
					throw HttpParameterBuildError.invalidType
				}
			}
		} catch {
			throw error
		}
	}
}
