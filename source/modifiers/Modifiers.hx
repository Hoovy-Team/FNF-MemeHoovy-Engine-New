package modifiers;

using StringTools;

/**
 * Unfinished at the moment.
 */
 typedef ModsList {
    public var reversedHealthbar:Bool;
}

class Modifiers
{
    public var mods:Array<ModsList> = new Array<ModsList>();

    public function setModEnabled(enabled:Bool = false, daString:String = "") {
        /*try {
            for (daMod in 0...mods) {
                // ((Std.isOfType(mods[daMod], Bool)) ? enabled : daString);
                (getModType() ? enabled : daString);
            }
        }
        catch (e:haxe.Exception) {
            throw new haxe.Exception('An horrible error occurred', e);
        }*/

        for (daMod in 0...mods) {
            // ((Std.isOfType(mods[daMod], Bool)) ? enabled : daString);
            (getModType() ? enabled : daString);

            if (getModType() == Type.typeof(Bool)){
                Reflect.setProperty(this, 'value', enabled);
            }
            else if (getModType() == Type.typeof(String)){
                Reflect.setProperty(this, 'value', daString);
            }
        }

        if (getModType() == null){
            throw new haxe.exceptions.NotImplementedException;
        }
    }

    public function getModType():Dynamic {
        var modToReturn:Dynamic = null;

        modToReturn = (Std.isOfType(mods[daMod], Dynamic));

        if (modToReturn != null)
            return modToReturn;
        else
            return null;
    }

    public inline function getMods() {
        return Reflect.copy(mods[getModType()]);
    }
}