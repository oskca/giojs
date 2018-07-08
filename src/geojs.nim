# nim_geojs
# Copyright oskca
# nim bindings for geojs
import jsffi
import dom

export dom
export jsffi

static:
    import ospaths, strutils
    let jslibs = parentDir(currentSourcePath()) / "jslibs"

{.emit: staticRead(jslibs / "three.min.js").}
{.emit: staticRead(jslibs / "gio.min.js").}

var GIO {. importc, nodecl .}: JsObject

type
    Controller* = JsObject
    Record* = object of RootObj
        e*: cstring
        i*: cstring
        v*: float
    Data* = seq[Record] 

proc newController*(el: Element): Controller =
    return jsnew GIO.Controller(el)

proc init*(c: Controller) {.importcpp: "#.init()".}
proc addData*(c: Controller, dat: JsObject) {.importcpp: "#.addData(#)".}
proc addData*(c: Controller, dat: Data) =
    c.addData(dat.toJs())    
proc addDataSync*(c: Controller, url: string, cb: proc()) {.importcpp: "#.addDataSync(@)".}
