" TODO
let current_compiler = "cpp"
CompilerSet makeprg=g++\ -Wall\ -Wextra\ -Werror\ $*\ build/a.out %
CompilerSet errorformat=%+A\ %#%f\ %#(%l\\\,%c):\ %m,%C%m
