@testable import HttpParameterKit
import XCTest

final class QueryTests: XCTestCase {
	func testNil() throws {
		XCTAssertEqual(try HPNil("nil").query((), encoding: .default), nil)
	}

	func testNilSuppress() throws {
		XCTAssertEqual(try HPNil("nil", suppressDefault: false).query((), encoding: .default), "nil=\0")
	}

	func testBoolFalse() throws {
		XCTAssertEqual(try HPBool("boolean").query(false, encoding: .default), nil)
	}

	func testBoolFalseSuppress() throws {
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .number).query(false, encoding: .default), "boolean=0")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lower).query(false, encoding: .default), "boolean=false")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upper).query(false, encoding: .default), "boolean=False")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .allUpper).query(false, encoding: .default), "boolean=FALSE")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerOne).query(false, encoding: .default), "boolean=f")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperOne).query(false, encoding: .default), "boolean=F")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerYesNo).query(false, encoding: .default), "boolean=no")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperYesNo).query(false, encoding: .default), "boolean=No")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .allUpperYesNo).query(false, encoding: .default), "boolean=NO")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerYesNoOne).query(false, encoding: .default), "boolean=n")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperYesNoOne).query(false, encoding: .default), "boolean=N")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .custom(false: "y", true: "x")).query(false, encoding: .default), "boolean=y")
	}

	func testBoolTrue() throws {
		XCTAssertEqual(try HPBool("boolean").query(true, encoding: .default), "boolean=T")
	}

	func testBoolTrueSuppress() throws {
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .number).query(true, encoding: .default), "boolean=1")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lower).query(true, encoding: .default), "boolean=true")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upper).query(true, encoding: .default), "boolean=True")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .allUpper).query(true, encoding: .default), "boolean=TRUE")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerOne).query(true, encoding: .default), "boolean=t")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperOne).query(true, encoding: .default), "boolean=T")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerYesNo).query(true, encoding: .default), "boolean=yes")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperYesNo).query(true, encoding: .default), "boolean=Yes")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .allUpperYesNo).query(true, encoding: .default), "boolean=YES")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerYesNoOne).query(true, encoding: .default), "boolean=y")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperYesNoOne).query(true, encoding: .default), "boolean=Y")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .custom(false: "y", true: "x")).query(true, encoding: .default), "boolean=x")
	}

	func testInt() throws {
		XCTAssertEqual(try HPInt("int").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPInt("int").query(Int.min, encoding: .default), "int=\(Int.min)")
		XCTAssertEqual(try HPInt("int").query(Int.max, encoding: .default), "int=\(Int.max)")
	}

	func testIntSuppress() throws {
		XCTAssertEqual(try HPInt("int", suppressDefault: false).query(0, encoding: .default), "int=0")
		XCTAssertEqual(try HPInt("int", suppressDefault: false).query(Int.min, encoding: .default), "int=\(Int.min)")
		XCTAssertEqual(try HPInt("int", suppressDefault: false).query(Int.max, encoding: .default), "int=\(Int.max)")
		XCTAssertThrowsError(try HPInt("int", min: Int.min + 1).query(Int.min, encoding: .default))
		XCTAssertThrowsError(try HPInt("int", max: Int.max - 1).query(Int.max, encoding: .default))
	}

	func testInt8() throws {
		XCTAssertEqual(try HPInt8("int8").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPInt8("int8").query(Int8.min, encoding: .default), "int8=\(Int8.min)")
		XCTAssertEqual(try HPInt8("int8").query(Int8.max, encoding: .default), "int8=\(Int8.max)")
	}

	func testInt8Suppress() throws {
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).query(0, encoding: .default), "int8=0")
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).query(Int8.min, encoding: .default), "int8=\(Int8.min)")
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).query(Int8.max, encoding: .default), "int8=\(Int8.max)")
		XCTAssertThrowsError(try HPInt8("int8", min: Int8.min + 1).query(Int8.min, encoding: .default))
		XCTAssertThrowsError(try HPInt8("int8", max: Int8.max - 1).query(Int8.max, encoding: .default))
	}

	func testInt16() throws {
		XCTAssertEqual(try HPInt16("int16").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPInt16("int16").query(Int16.min, encoding: .default), "int16=\(Int16.min)")
		XCTAssertEqual(try HPInt16("int16").query(Int16.max, encoding: .default), "int16=\(Int16.max)")
	}

	func testInt16Suppress() throws {
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).query(0, encoding: .default), "int16=0")
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).query(Int16.min, encoding: .default), "int16=\(Int16.min)")
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).query(Int16.max, encoding: .default), "int16=\(Int16.max)")
		XCTAssertThrowsError(try HPInt16("int16", min: Int16.min + 1).query(Int16.min, encoding: .default))
		XCTAssertThrowsError(try HPInt16("int16", max: Int16.max - 1).query(Int16.max, encoding: .default))
	}

	func testInt32() throws {
		XCTAssertEqual(try HPInt32("int32").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPInt32("int32").query(Int32.min, encoding: .default), "int32=\(Int32.min)")
		XCTAssertEqual(try HPInt32("int32").query(Int32.max, encoding: .default), "int32=\(Int32.max)")
	}

	func testInt32Suppress() throws {
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).query(0, encoding: .default), "int32=0")
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).query(Int32.min, encoding: .default), "int32=\(Int32.min)")
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).query(Int32.max, encoding: .default), "int32=\(Int32.max)")
		XCTAssertThrowsError(try HPInt32("int32", min: Int32.min + 1).query(Int32.min, encoding: .default))
		XCTAssertThrowsError(try HPInt32("int32", max: Int32.max - 1).query(Int32.max, encoding: .default))
	}

	func testInt64() throws {
		XCTAssertEqual(try HPInt64("int64").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPInt64("int64").query(Int64.min, encoding: .default), "int64=\(Int64.min)")
		XCTAssertEqual(try HPInt64("int64").query(Int64.max, encoding: .default), "int64=\(Int64.max)")
	}

	func testInt64Suppress() throws {
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).query(0, encoding: .default), "int64=0")
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).query(Int64.min, encoding: .default), "int64=\(Int64.min)")
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).query(Int64.max, encoding: .default), "int64=\(Int64.max)")
		XCTAssertThrowsError(try HPInt64("int64", min: Int64.min + 1).query(Int64.min, encoding: .default))
		XCTAssertThrowsError(try HPInt64("int64", max: Int64.max - 1).query(Int64.max, encoding: .default))
	}

	func testUInt() throws {
		XCTAssertEqual(try HPUInt("uint").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPUInt("uint").query(UInt.max, encoding: .default), "uint=\(UInt.max)")
	}

	func testUIntSuppress() throws {
		XCTAssertEqual(try HPUInt("uint", suppressDefault: false).query(0, encoding: .default), "uint=0")
		XCTAssertEqual(try HPUInt("uint", suppressDefault: false).query(UInt.max, encoding: .default), "uint=\(UInt.max)")
		XCTAssertThrowsError(try HPUInt("uint", min: UInt.min + 1).query(UInt.min, encoding: .default))
		XCTAssertThrowsError(try HPUInt("uint", max: UInt.max - 1).query(UInt.max, encoding: .default))
	}

	func testUInt8() throws {
		XCTAssertEqual(try HPUInt8("uint8").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPUInt8("uint8").query(UInt8.max, encoding: .default), "uint8=\(UInt8.max)")
	}

	func testUInt8Suppress() throws {
		XCTAssertEqual(try HPUInt8("uint8", suppressDefault: false).query(0, encoding: .default), "uint8=0")
		XCTAssertEqual(try HPUInt8("uint8", suppressDefault: false).query(UInt8.max, encoding: .default), "uint8=\(UInt8.max)")
		XCTAssertThrowsError(try HPUInt8("uint8", min: UInt8.min + 1).query(UInt8.min, encoding: .default))
		XCTAssertThrowsError(try HPUInt8("uint8", max: UInt8.max - 1).query(UInt8.max, encoding: .default))
	}

	func testUInt16() throws {
		XCTAssertEqual(try HPUInt16("uint16").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPUInt16("uint16").query(UInt16.max, encoding: .default), "uint16=\(UInt16.max)")
	}

	func testUInt16Suppress() throws {
		XCTAssertEqual(try HPUInt16("uint16", suppressDefault: false).query(0, encoding: .default), "uint16=0")
		XCTAssertEqual(try HPUInt16("uint16", suppressDefault: false).query(UInt16.max, encoding: .default), "uint16=\(UInt16.max)")
		XCTAssertThrowsError(try HPUInt16("uint16", min: UInt16.min + 1).query(UInt16.min, encoding: .default))
		XCTAssertThrowsError(try HPUInt16("uint16", max: UInt16.max - 1).query(UInt16.max, encoding: .default))
	}

	func testUInt32() throws {
		XCTAssertEqual(try HPUInt32("uint32").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPUInt32("uint32").query(UInt32.max, encoding: .default), "uint32=\(UInt32.max)")
	}

	func testUInt32Suppress() throws {
		XCTAssertEqual(try HPUInt32("uint32", suppressDefault: false).query(0, encoding: .default), "uint32=0")
		XCTAssertEqual(try HPUInt32("uint32", suppressDefault: false).query(UInt32.max, encoding: .default), "uint32=\(UInt32.max)")
		XCTAssertThrowsError(try HPUInt32("uint32", min: UInt32.min + 1).query(UInt32.min, encoding: .default))
		XCTAssertThrowsError(try HPUInt32("uint32", max: UInt32.max - 1).query(UInt32.max, encoding: .default))
	}

	func testUInt64() throws {
		XCTAssertEqual(try HPUInt64("uint64").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPUInt64("uint64").query(UInt64.max, encoding: .default), "uint64=\(UInt64.max)")
	}

	func testUInt64Suppress() throws {
		XCTAssertEqual(try HPUInt64("uint64", suppressDefault: false).query(0, encoding: .default), "uint64=0")
		XCTAssertEqual(try HPUInt64("uint64", suppressDefault: false).query(UInt64.max, encoding: .default), "uint64=\(UInt64.max)")
		XCTAssertThrowsError(try HPUInt64("uint64", min: UInt64.min + 1).query(UInt64.min, encoding: .default))
		XCTAssertThrowsError(try HPUInt64("uint64", max: UInt64.max - 1).query(UInt64.max, encoding: .default))
	}

#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))
	@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
	func testFloat16() throws {
		XCTAssertEqual(try HPFloat16("float16").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPFloat16("float16").query(Float16.leastNormalMagnitude, encoding: .default), "float16=\(Float16.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat16("float16").query(Float16.greatestFiniteMagnitude, encoding: .default), "float16=\(Float16.greatestFiniteMagnitude)")
	}

	@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
	func testFloat16Suppress() throws {
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).query(0, encoding: .default), "float16=0.0")
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).query(Float16.leastNormalMagnitude, encoding: .default), "float16=\(Float16.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).query(Float16.greatestFiniteMagnitude, encoding: .default), "float16=\(Float16.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPFloat16("float16", min: 40).query(20, encoding: .default))
		XCTAssertThrowsError(try HPFloat16("float16", max: 40).query(60, encoding: .default))
	}
#endif

	func testFloat() throws {
		XCTAssertEqual(try HPFloat("float").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPFloat("float").query(Float.leastNormalMagnitude, encoding: .default), "float=\(Float.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat("float").query(Float.greatestFiniteMagnitude, encoding: .default), "float=\(Float.greatestFiniteMagnitude)")
	}

	func testFloatSuppress() throws {
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).query(0, encoding: .default), "float=0.0")
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).query(Float.leastNormalMagnitude, encoding: .default), "float=\(Float.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).query(Float.greatestFiniteMagnitude, encoding: .default), "float=\(Float.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPFloat("float", min: 40).query(20, encoding: .default))
		XCTAssertThrowsError(try HPFloat("float", max: 40).query(60, encoding: .default))
	}

	func testDouble() throws {
		XCTAssertEqual(try HPDouble("double").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPDouble("double").query(Double.leastNormalMagnitude, encoding: .default), "double=\(Double.leastNormalMagnitude)")
		XCTAssertEqual(try HPDouble("double").query(Double.greatestFiniteMagnitude, encoding: .default), "double=\(Double.greatestFiniteMagnitude)")
	}

	func testDoubleSuppress() throws {
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).query(0, encoding: .default), "double=0.0")
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).query(Double.leastNormalMagnitude, encoding: .default), "double=\(Double.leastNormalMagnitude)")
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).query(Double.greatestFiniteMagnitude, encoding: .default), "double=\(Double.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPDouble("double", min: 40).query(20, encoding: .default))
		XCTAssertThrowsError(try HPDouble("double", max: 40).query(60, encoding: .default))
	}

#if swift(>=1.1) && os(macOS)
	@available(macOS 10.10, *)
	func testFloat80() throws {
		XCTAssertEqual(try HPFloat80("float80").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPFloat80("float80").query(Float80.leastNormalMagnitude, encoding: .default), "float80=\(Float80.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat80("float80").query(Float80.greatestFiniteMagnitude, encoding: .default), "float80=\(Float80.greatestFiniteMagnitude)")
	}

	@available(macOS 10.10, *)
	func testFloat80Suppress() throws {
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).query(0, encoding: .default), "float80=0.0")
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).query(Float80.leastNormalMagnitude, encoding: .default), "float80=\(Float80.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).query(Float80.greatestFiniteMagnitude, encoding: .default), "float80=\(Float80.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPFloat80("float80", min: 40).query(20, encoding: .default))
		XCTAssertThrowsError(try HPFloat80("float80", max: 40).query(60, encoding: .default))
	}
#endif

	func testCGFloat() throws {
		XCTAssertEqual(try HPCGFloat("cgfloat").query(0, encoding: .default), nil)
		XCTAssertEqual(try HPCGFloat("cgfloat").query(CGFloat.leastNormalMagnitude, encoding: .default), "cgfloat=\(CGFloat.leastNormalMagnitude)")
		XCTAssertEqual(try HPCGFloat("cgfloat").query(CGFloat.greatestFiniteMagnitude, encoding: .default), "cgfloat=\(CGFloat.greatestFiniteMagnitude)")
	}

	func testCGFloatSuppress() throws {
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).query(0, encoding: .default), "cgfloat=0.0")
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).query(CGFloat.leastNormalMagnitude, encoding: .default), "cgfloat=\(CGFloat.leastNormalMagnitude)")
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).query(CGFloat.greatestFiniteMagnitude, encoding: .default), "cgfloat=\(CGFloat.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPCGFloat("cgfloat", min: 40).query(20, encoding: .default))
		XCTAssertThrowsError(try HPCGFloat("cgfloat", max: 40).query(60, encoding: .default))
	}
}
