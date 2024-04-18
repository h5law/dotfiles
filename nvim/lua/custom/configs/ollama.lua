local opts = {
  model = "codeqwen:latest",
  prompts = {
    Brief_Context =
    "I am a software engineer with experience in go, python and rust - looking to solve problems and build intuition around fundamental computer science comcepts.\n\n$input",
    input_label = "|»> ",
    model = "openchat:latest",
    action = "display",
  },
}

return opts
