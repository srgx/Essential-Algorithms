# Exercise 16

def reverseThread(root)
  node, viaBranch = root, true
  while(!node.nil?)

    if(viaBranch)
      while(!node.rightChild.nil?)
        node = node.rightChild
      end
    end

    puts node.value

    if(node.leftChild.nil?)
      node = node.leftThread
      viaBranch = false
    else
      node = node.leftChild
      viaBranch = true
    end

  end
end
