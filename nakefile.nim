import nake
import strutils
import os
import terminal

const
  ROOT_TEST_DIR = "tests"

task "clean", "Removes nimcache folders, compiled exes":
  removeDir("nimcache")
  removeDir("bin")

task "build", "Builds nimdown executable":
  createDir("bin")
  direshell("nim", "c", "--verbosity:0", "--out:bin/nimdown", "nimdown.nim")

task "test", "Runs tests":
  for ftype, testf in walkDir(ROOT_TEST_DIR):
    if testf.startsWith(os.joinPath(ROOT_TEST_DIR, "test_")) and testf.endsWith(".nim"):
      shell("nim", "c", "--verbosity:0", "-r", testf)
