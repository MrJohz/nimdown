import strtabs

type
  State* = object of RootObj
    map: StringTableRef

proc hellothing*() = echo "hello"