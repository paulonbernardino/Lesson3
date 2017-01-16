#Hello World
HelloWorld <- function (x) {
  hello <- sprintf('Hello %s', x)
  return(hello)
}

# Let's test it
HelloWorld('john')

HelloWorld <- function (x) {
  if (is.character(x)) {
    hello <- sprintf('Hello %s', x)
  } else {
    hello <- warning('Object of class character expected for x')
  }
  return(hello)
}

HelloWorld(21)
