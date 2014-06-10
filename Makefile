
# Set OCamlMakefile to use
export OCAMLMAKEFILE = ./OCamlMakefile

SOURCES=higher.mli higher.ml

RESULT=higher

LIBINSTALL_FILES := higher.mli higher.cmi \
                    higher.cma \
                    higher.cmx higher.cmxa higher.a

all: byte-code-library native-code-library

examples-install:
	ocamlfind install -add higher examples/*

install: libinstall examples-install
uninstall: libuninstall

include $(OCAMLMAKEFILE)
