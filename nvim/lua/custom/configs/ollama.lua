local opts = {
  model = "llama3:latest",
  prompts = {
    Brief_Context =
    "I am a software engineer working in go, typescript, python and rust. I am looking to solve problems and build intuition around fundamental computer science comcepts.\n\n$input",
    input_label = "|»> ",
    model = "llama3:latest",
    action = "display",
  },
}

return opts
