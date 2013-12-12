
# Set OCamlMakefile to use
export OCAMLMAKEFILE = ./OCamlMakefile

SOURCES=higher.mli higher.ml

RESULT=higher

LIBINSTALL_FILES := higher.mli higher.cmi \
                    higher.cma \
                    higher.cmx higher.cmxa higher.a

all: byte-code-library native-code-library

install: libinstall
uninstall: libuninstall

include $(OCAMLMAKEFILE)
