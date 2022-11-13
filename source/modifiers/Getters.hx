package modifiers; // getters AND setters, so this class name is technically a lie

/**
 * @author MemeHoovy
 */
class Getters {
    @:isVar public var daType(get, set):Any;

    private inline function get_daType(typeBud:Dynamic):Any {
        // return Type.typeof(typeBud);
        return Std.isOfType(typeBud, Any);
    }

    private function set_daType(anything:Any, typeBud:Dynamic):Any {
        return anything = typeBud;
    }

    public inline function getBool(daBool:Bool):Bool {
        return Std.isOfType(daBool, Bool);
    }

    public inline function getString(daString:String):String {
        return Std.isOfType(daString, String);
    }

    public inline function getAny(daAny:Dynamic):Any {
        return Std.isOfType(daAny, Any);
    }

    public function setAnyValue():Any {
        return 0;
    }
}