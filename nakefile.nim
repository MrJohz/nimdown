import nake
import strutils
import os
import terminal

const
  ROOT_TEST_DIR = "tests"
  SRC_DIR = "src"
  BIN_DIR = "bin"
  BIN_NAME = "nimdown" & ExeExt


task "clean", "Removes nimcache folders, compiled exes":
  removeDir("nimcache")
  removeDir(BIN_DIR)

task "build", "Builds nimdown executable":
  withDir(SRC_DIR):
    createDir(".." / BIN_DIR)
    direshell("nim", "c", "--verbosity:0", "--out:" & (".." / BIN_DIR / BIN_NAME), "nimdown.nim")

task "test-spec", "Test nimdown against the CommonMark spec (in ./CommonMark":
  if needsRefresh(BIN_NAME, "nimdown.nim"):
    runTask("build")

  withDir "CommonMark":
    shell("make", "test", "PROG=.." / BIN_DIR / BIN_NAME)

task "test-unit", "Test nimdown against internal unit tests":
  for ftype, testf in walkDir(ROOT_TEST_DIR):
    if testf.startsWith(ROOT_TEST_DIR / "test_") and testf.endsWith(".nim"):
      shell("nim", "c", "--verbosity:0", "-r", testf)

task "test-all", "Runs test-unit and test-spec":
  runTask("test-unit")
  runTask("test-spec")
