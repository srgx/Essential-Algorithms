# Exercise 8
# If m<n algorithm changes order of arguments

module Algorithm
  def Algorithm.euclid(m,n)
    while(n!=0)
      r=m%n
      m=n
      n=r
    end
    return m
  end
end
