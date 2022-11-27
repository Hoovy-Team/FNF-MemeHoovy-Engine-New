package modifiers; // getters AND setters, so this class name is technically a lie

/**
 * @author MemeHoovy
 */
class Getters {
    @:isVar public static var daType(get, set):Any;

    private static inline function get_daType(typeBud:Dynamic):Any {
        // return Type.typeof(typeBud);
        return Std.isOfType(typeBud, Any);
    }

    private static inline function set_daType(typeBud:Dynamic) {
        return daType = typeBud;
    }    

    public static inline function getBool(daBool:Bool):Bool {
        if (Std.isOfType(daBool, Bool))
            return daBool;
    }

    public static inline function getString(daString:String):String {
        if(Std.isOfType(daString, String))
            return daString;
    }

    public static inline function getAny():Any {
        return 0;
    }

    /**
     * [Description] Returns the different possible runtime types of a value.
     * @param daTypeName The type, see below for a list.
     * @see `https://api.haxe.org/ValueType.html` 
     */
    public static function returnTypeName(daTypeName:Dynamic){
        return switch(Type.typeof(daTypeName)) {
            case TEnum(e):
                Type.getEnumName(e);
            case TClass(c):
                Type.getClassName(c);
            case TInt:
                'int';
			case TFloat:
				"float";
			case TBool:
				"bool";
			case TObject:
				"object";
			case TFunction:
				"function";
			case TNull:
				"null";
			case TUnknown:
				"unknown";
			default:
				"";
        }
    }
}