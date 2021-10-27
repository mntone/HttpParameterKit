@testable import HttpParameterKit
import XCTest

final class QueryTests: XCTestCase {
	func testNil() throws {
		XCTAssertEqual(try HPNil("nil").query(()), nil)
	}

	func testNilSuppress() throws {
		XCTAssertEqual(try HPNil("nil", suppressDefault: false).query(()), "nil=\0")
	}

	func testBoolFalse() throws {
		XCTAssertEqual(try HPBool("boolean").query(false), nil)
	}

	func testBoolFalseSuppress() throws {
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .number).query(false), "boolean=0")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lower).query(false), "boolean=false")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upper).query(false), "boolean=False")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .allUpper).query(false), "boolean=FALSE")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerOne).query(false), "boolean=f")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperOne).query(false), "boolean=F")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerYesNo).query(false), "boolean=no")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperYesNo).query(false), "boolean=No")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .allUpperYesNo).query(false), "boolean=NO")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerYesNoOne).query(false), "boolean=n")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperYesNoOne).query(false), "boolean=N")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .custom(false: "y", true: "x")).query(false), "boolean=y")
	}

	func testBoolTrue() throws {
		XCTAssertEqual(try HPBool("boolean").query(true), "boolean=T")
	}

	func testBoolTrueSuppress() throws {
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .number).query(true), "boolean=1")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lower).query(true), "boolean=true")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upper).query(true), "boolean=True")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .allUpper).query(true), "boolean=TRUE")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerOne).query(true), "boolean=t")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperOne).query(true), "boolean=T")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerYesNo).query(true), "boolean=yes")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperYesNo).query(true), "boolean=Yes")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .allUpperYesNo).query(true), "boolean=YES")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .lowerYesNoOne).query(true), "boolean=y")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .upperYesNoOne).query(true), "boolean=Y")
		XCTAssertEqual(try HPBool("boolean", suppressDefault: false, output: .custom(false: "y", true: "x")).query(true), "boolean=x")
	}

	func testInt() throws {
		XCTAssertEqual(try HPInt("int").query(0), nil)
		XCTAssertEqual(try HPInt("int").query(Int.min), "int=\(Int.min)")
		XCTAssertEqual(try HPInt("int").query(Int.max), "int=\(Int.max)")
	}

	func testIntSuppress() throws {
		XCTAssertEqual(try HPInt("int", suppressDefault: false).query(0), "int=0")
		XCTAssertEqual(try HPInt("int", suppressDefault: false).query(Int.min), "int=\(Int.min)")
		XCTAssertEqual(try HPInt("int", suppressDefault: false).query(Int.max), "int=\(Int.max)")
		XCTAssertThrowsError(try HPInt("int", min: Int.min + 1).query(Int.min))
		XCTAssertThrowsError(try HPInt("int", max: Int.max - 1).query(Int.max))
	}

	func testInt8() throws {
		XCTAssertEqual(try HPInt8("int8").query(0), nil)
		XCTAssertEqual(try HPInt8("int8").query(Int8.min), "int8=\(Int8.min)")
		XCTAssertEqual(try HPInt8("int8").query(Int8.max), "int8=\(Int8.max)")
	}

	func testInt8Suppress() throws {
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).query(0), "int8=0")
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).query(Int8.min), "int8=\(Int8.min)")
		XCTAssertEqual(try HPInt8("int8", suppressDefault: false).query(Int8.max), "int8=\(Int8.max)")
		XCTAssertThrowsError(try HPInt8("int8", min: Int8.min + 1).query(Int8.min))
		XCTAssertThrowsError(try HPInt8("int8", max: Int8.max - 1).query(Int8.max))
	}

	func testInt16() throws {
		XCTAssertEqual(try HPInt16("int16").query(0), nil)
		XCTAssertEqual(try HPInt16("int16").query(Int16.min), "int16=\(Int16.min)")
		XCTAssertEqual(try HPInt16("int16").query(Int16.max), "int16=\(Int16.max)")
	}

	func testInt16Suppress() throws {
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).query(0), "int16=0")
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).query(Int16.min), "int16=\(Int16.min)")
		XCTAssertEqual(try HPInt16("int16", suppressDefault: false).query(Int16.max), "int16=\(Int16.max)")
		XCTAssertThrowsError(try HPInt16("int16", min: Int16.min + 1).query(Int16.min))
		XCTAssertThrowsError(try HPInt16("int16", max: Int16.max - 1).query(Int16.max))
	}

	func testInt32() throws {
		XCTAssertEqual(try HPInt32("int32").query(0), nil)
		XCTAssertEqual(try HPInt32("int32").query(Int32.min), "int32=\(Int32.min)")
		XCTAssertEqual(try HPInt32("int32").query(Int32.max), "int32=\(Int32.max)")
	}

	func testInt32Suppress() throws {
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).query(0), "int32=0")
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).query(Int32.min), "int32=\(Int32.min)")
		XCTAssertEqual(try HPInt32("int32", suppressDefault: false).query(Int32.max), "int32=\(Int32.max)")
		XCTAssertThrowsError(try HPInt32("int32", min: Int32.min + 1).query(Int32.min))
		XCTAssertThrowsError(try HPInt32("int32", max: Int32.max - 1).query(Int32.max))
	}

	func testInt64() throws {
		XCTAssertEqual(try HPInt64("int64").query(0), nil)
		XCTAssertEqual(try HPInt64("int64").query(Int64.min), "int64=\(Int64.min)")
		XCTAssertEqual(try HPInt64("int64").query(Int64.max), "int64=\(Int64.max)")
	}

	func testInt64Suppress() throws {
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).query(0), "int64=0")
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).query(Int64.min), "int64=\(Int64.min)")
		XCTAssertEqual(try HPInt64("int64", suppressDefault: false).query(Int64.max), "int64=\(Int64.max)")
		XCTAssertThrowsError(try HPInt64("int64", min: Int64.min + 1).query(Int64.min))
		XCTAssertThrowsError(try HPInt64("int64", max: Int64.max - 1).query(Int64.max))
	}

	func testUInt() throws {
		XCTAssertEqual(try HPUInt("uint").query(0), nil)
		XCTAssertEqual(try HPUInt("uint").query(UInt.max), "uint=\(UInt.max)")
	}

	func testUIntSuppress() throws {
		XCTAssertEqual(try HPUInt("uint", suppressDefault: false).query(0), "uint=0")
		XCTAssertEqual(try HPUInt("uint", suppressDefault: false).query(UInt.max), "uint=\(UInt.max)")
		XCTAssertThrowsError(try HPUInt("uint", min: UInt.min + 1).query(UInt.min))
		XCTAssertThrowsError(try HPUInt("uint", max: UInt.max - 1).query(UInt.max))
	}

	func testUInt8() throws {
		XCTAssertEqual(try HPUInt8("uint8").query(0), nil)
		XCTAssertEqual(try HPUInt8("uint8").query(UInt8.max), "uint8=\(UInt8.max)")
	}

	func testUInt8Suppress() throws {
		XCTAssertEqual(try HPUInt8("uint8", suppressDefault: false).query(0), "uint8=0")
		XCTAssertEqual(try HPUInt8("uint8", suppressDefault: false).query(UInt8.max), "uint8=\(UInt8.max)")
		XCTAssertThrowsError(try HPUInt8("uint8", min: UInt8.min + 1).query(UInt8.min))
		XCTAssertThrowsError(try HPUInt8("uint8", max: UInt8.max - 1).query(UInt8.max))
	}

	func testUInt16() throws {
		XCTAssertEqual(try HPUInt16("uint16").query(0), nil)
		XCTAssertEqual(try HPUInt16("uint16").query(UInt16.max), "uint16=\(UInt16.max)")
	}

	func testUInt16Suppress() throws {
		XCTAssertEqual(try HPUInt16("uint16", suppressDefault: false).query(0), "uint16=0")
		XCTAssertEqual(try HPUInt16("uint16", suppressDefault: false).query(UInt16.max), "uint16=\(UInt16.max)")
		XCTAssertThrowsError(try HPUInt16("uint16", min: UInt16.min + 1).query(UInt16.min))
		XCTAssertThrowsError(try HPUInt16("uint16", max: UInt16.max - 1).query(UInt16.max))
	}

	func testUInt32() throws {
		XCTAssertEqual(try HPUInt32("uint32").query(0), nil)
		XCTAssertEqual(try HPUInt32("uint32").query(UInt32.max), "uint32=\(UInt32.max)")
	}

	func testUInt32Suppress() throws {
		XCTAssertEqual(try HPUInt32("uint32", suppressDefault: false).query(0), "uint32=0")
		XCTAssertEqual(try HPUInt32("uint32", suppressDefault: false).query(UInt32.max), "uint32=\(UInt32.max)")
		XCTAssertThrowsError(try HPUInt32("uint32", min: UInt32.min + 1).query(UInt32.min))
		XCTAssertThrowsError(try HPUInt32("uint32", max: UInt32.max - 1).query(UInt32.max))
	}

	func testUInt64() throws {
		XCTAssertEqual(try HPUInt64("uint64").query(0), nil)
		XCTAssertEqual(try HPUInt64("uint64").query(UInt64.max), "uint64=\(UInt64.max)")
	}

	func testUInt64Suppress() throws {
		XCTAssertEqual(try HPUInt64("uint64", suppressDefault: false).query(0), "uint64=0")
		XCTAssertEqual(try HPUInt64("uint64", suppressDefault: false).query(UInt64.max), "uint64=\(UInt64.max)")
		XCTAssertThrowsError(try HPUInt64("uint64", min: UInt64.min + 1).query(UInt64.min))
		XCTAssertThrowsError(try HPUInt64("uint64", max: UInt64.max - 1).query(UInt64.max))
	}

#if swift(>=5.3) && (os(iOS) || os(watchOS) || os(tvOS))
	@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
	func testFloat16() throws {
		XCTAssertEqual(try HPFloat16("float16").query(0), nil)
		XCTAssertEqual(try HPFloat16("float16").query(Float16.leastNormalMagnitude), "float16=\(Float16.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat16("float16").query(Float16.greatestFiniteMagnitude), "float16=\(Float16.greatestFiniteMagnitude)")
	}

	@available(iOS 14.0, watchOS 7.0, tvOS 14.0, *)
	func testFloat16Suppress() throws {
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).query(0), "float16=0.0")
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).query(Float16.leastNormalMagnitude), "float16=\(Float16.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat16("float16", suppressDefault: false).query(Float16.greatestFiniteMagnitude), "float16=\(Float16.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPFloat16("float16", min: 40).query(20))
		XCTAssertThrowsError(try HPFloat16("float16", max: 40).query(60))
	}
#endif

	func testFloat() throws {
		XCTAssertEqual(try HPFloat("float").query(0), nil)
		XCTAssertEqual(try HPFloat("float").query(Float.leastNormalMagnitude), "float=\(Float.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat("float").query(Float.greatestFiniteMagnitude), "float=\(Float.greatestFiniteMagnitude)")
	}

	func testFloatSuppress() throws {
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).query(0), "float=0.0")
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).query(Float.leastNormalMagnitude), "float=\(Float.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat("float", suppressDefault: false).query(Float.greatestFiniteMagnitude), "float=\(Float.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPFloat("float", min: 40).query(20))
		XCTAssertThrowsError(try HPFloat("float", max: 40).query(60))
	}

	func testDouble() throws {
		XCTAssertEqual(try HPDouble("double").query(0), nil)
		XCTAssertEqual(try HPDouble("double").query(Double.leastNormalMagnitude), "double=\(Double.leastNormalMagnitude)")
		XCTAssertEqual(try HPDouble("double").query(Double.greatestFiniteMagnitude), "double=\(Double.greatestFiniteMagnitude)")
	}

	func testDoubleSuppress() throws {
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).query(0), "double=0.0")
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).query(Double.leastNormalMagnitude), "double=\(Double.leastNormalMagnitude)")
		XCTAssertEqual(try HPDouble("double", suppressDefault: false).query(Double.greatestFiniteMagnitude), "double=\(Double.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPDouble("double", min: 40).query(20))
		XCTAssertThrowsError(try HPDouble("double", max: 40).query(60))
	}

#if swift(>=1.1) && os(macOS)
	@available(macOS 10.10, *)
	func testFloat80() throws {
		XCTAssertEqual(try HPFloat80("float80").query(0), nil)
		XCTAssertEqual(try HPFloat80("float80").query(Float80.leastNormalMagnitude), "float80=\(Float80.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat80("float80").query(Float80.greatestFiniteMagnitude), "float80=\(Float80.greatestFiniteMagnitude)")
	}

	@available(macOS 10.10, *)
	func testFloat80Suppress() throws {
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).query(0), "float80=0.0")
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).query(Float80.leastNormalMagnitude), "float80=\(Float80.leastNormalMagnitude)")
		XCTAssertEqual(try HPFloat80("float80", suppressDefault: false).query(Float80.greatestFiniteMagnitude), "float80=\(Float80.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPFloat80("float80", min: 40).query(20))
		XCTAssertThrowsError(try HPFloat80("float80", max: 40).query(60))
	}
#endif

	func testCGFloat() throws {
		XCTAssertEqual(try HPCGFloat("cgfloat").query(0), nil)
		XCTAssertEqual(try HPCGFloat("cgfloat").query(CGFloat.leastNormalMagnitude), "cgfloat=\(CGFloat.leastNormalMagnitude)")
		XCTAssertEqual(try HPCGFloat("cgfloat").query(CGFloat.greatestFiniteMagnitude), "cgfloat=\(CGFloat.greatestFiniteMagnitude)")
	}

	func testCGFloatSuppress() throws {
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).query(0), "cgfloat=0.0")
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).query(CGFloat.leastNormalMagnitude), "cgfloat=\(CGFloat.leastNormalMagnitude)")
		XCTAssertEqual(try HPCGFloat("cgfloat", suppressDefault: false).query(CGFloat.greatestFiniteMagnitude), "cgfloat=\(CGFloat.greatestFiniteMagnitude)")
		XCTAssertThrowsError(try HPCGFloat("cgfloat", min: 40).query(20))
		XCTAssertThrowsError(try HPCGFloat("cgfloat", max: 40).query(60))
	}
}
