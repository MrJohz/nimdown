import strutils

type
  Preprocessor* = ref PreprocessorObj
  PreprocessorObj* = object of RootObj
    ## Preprocessor.  This should be extended, and a new `run`
    ## implementation added in other cases.
    run*: proc (p: Preprocessor, s: string): string

  PreprocessorParser* = object of RootObj
    ## Parser type, contains all preprocessors
    preprocessors*: seq[Preprocessor]

proc addPreprocessor*(psr: var PreprocessorParser, prep: Preprocessor) =
  ## Adds a preprocessor to the end of the parser
  psr.preprocessors.add(prep)

proc addPreprocessor*(psr: var PreprocessorParser, prep: Preprocessor, pos: int) =
  ## Inserts a preprocessor into the parser at position `pos`.
  psr.preprocessors.insert(prep, pos)

proc run*(psr: var PreprocessorParser, inp: string): string =
  ## Runs the parser with input `inp`, outputting another string.
  var text = inp
  for prep in psr.preprocessors:
    text = prep.run(prep, text)
  result = text


type
  NewlinePreprocessor* = ref NewlinePreprocessorObj
  NewlinePreprocessorObj* = object of Preprocessor

proc newlineRun(p: Preprocessor, s: string): string =
  var strings: seq[string] = @[]
  for line in s.splitLines:
    strings.add(line)
  result = strings.join("\n")

type
  TabspacingPreprocessor* = ref TabspacingPreprocessorObj
  TabspacingPreprocessorObj* = object of Preprocessor

proc tabSpaceRun(p: Preprocessor, s: string): string =
  return s.replace("\t", "    ")

proc newPreprocessorParser*(): PreprocessorParser =
  result = PreprocessorParser(preprocessors: @[])

  result.addPreprocessor(NewlinePreprocessor(run: newlineRun))
  result.addPreprocessor(TabspacingPreprocessor(run: tabSpaceRun))
