# Sometimes this is a module, other times it's a script.
# Only generate the correct type of file.
{.deadCodeElim: on.}

when isMainModule:
  import private/script

  quit(main())

else:
  import private/library
  export library.parse

  import private/preprocessors
  export preprocessors

  import private/state
  export state
  export state.`[]`
  export state.`[]=`

  import strtabs
  export strtabs.`[]`
  export strtabs.`[]=`