
# Set OCamlMakefile to use
export OCAMLMAKEFILE = ./OCamlMakefile

SOURCES=higher.mli higher.ml

RESULT=higher

LIBINSTALL_FILES := higher.mli higher.cmi \
                    higher.cma

NATIVE_LIBINSTALL_FILES := \
                    higher.cmx higher.cmxa higher.a

all: byte-code-library native-code-library

meta-install:
	$(OCAMLFIND) install higher META

byte-code-lib-install: byte-code-library
	ocamlfind install -add higher $(LIBINSTALL_FILES)

examples-install:
	ocamlfind install -add higher examples/*

native-lib-install: native-code-library
	ocamlfind install -add higher $(NATIVE_LIBINSTALL_FILES)

byte-code-install: meta-install byte-code-lib-install examples-install
native-install: byte-code-install native-lib-install
install: native-install
uninstall:
	$(OCAMLFIND) remove higher

include $(OCAMLMAKEFILE)
