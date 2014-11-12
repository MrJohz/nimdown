import streams
import library

proc main*(): int =
  var inpstream = newFileStream(stdin)
  var outstream = newFileStream(stdout)

  parse(inpstream, outstream)

  return 0
