#!/usr/bin/ruby

def inputInterpreter()

  mThread = Thread.new{

    cmd = cmd.chomp()

    if inputAnalizer(cmd) == -1
      return -1
    end
  }
end

def inputAnalizer(cmd="")

end