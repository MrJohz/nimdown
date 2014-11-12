import preprocessors
import streams

proc parse*(input: string): string =
  result = input

  var preprocs = newPreprocessorParser()
  result = preprocs.run(input)

proc parse*(input, output: Stream) =
  var text = ""
  while not input.atEnd:
    text.add(input.readLine() & "\n")

  let returned = parse(text)
  output.write(returned)
