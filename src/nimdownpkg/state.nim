import critbits
import strtabs
export strtabs.`[]`
export strtabs.`[]=`

type
  State* = object of RootObj
    map: CritBitTree[StringTableRef]

proc `.`(s: State, key: string): StringTableRef =
  if s.map.contains(key):
    return s.map[key]
  else:
    s.map[key] = newStringTable(modeCaseSensitive)
    return s.map[key]