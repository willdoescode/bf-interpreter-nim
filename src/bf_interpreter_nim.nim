import os, algorithm

const BUFFERSIZE: int = 65535
var 
  buf: array[BUFFERSIZE, int]
  cur: int

proc evalContents(s: string) {.discardable.} =
  fill(buf, 0)
  cur = 0

  var i = 0
  while (i < s.len):
    case s[i]:
      of '>':
        cur += 1
        if (cur >= BUFFERSIZE): cur = 0
      of '<':
        cur -= 1
        if (cur < 0): cur = BUFFERSIZE - 1
      of '+': buf[cur] += 1
      of '-': buf[cur] -= 1
      of '[':
        if (buf[cur] == 0):
          var loop = 1
          while (loop > 0):
            i += 1
            let c = s[i]
            if (c == '['): loop += 1 elif (c == ']'): loop -= 1
      of ']':
        var loop = 1
        while (loop > 0):
          i -= 1
          let c = s[i]
          if (c == '['): loop -= 1 elif (c == ']'): loop += 1
        i -= 1
      
      of ',': buf[cur] = ord(stdin.readChar())
      of '.': stdout.write char(buf[cur])
      else: stdout.write ""
    i += 1

proc main =
  for arg in commandLineParams(): 
    if fileExists(arg): evalContents(readFile(arg))

when isMainModule: main()
