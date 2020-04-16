require_relative 'exercise17.rb'
# Exercise 20


def main
  file1, file2 = "file1.txt", "file2.txt"
  first, second = File.read(file1), File.read(file2)

  # replace newlines with '|'
  first.gsub!("\n",'|')
  second.gsub!("\n",'|')


  nodes = createNodes(first,second)
  setDistances(first,second,nodes)
  changes = getChanges(first,second,nodes)


  displayMessage(first,second,nodes,25)
  displayEdits(changes,30,20)

  show
end

# main
