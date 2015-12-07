
# Set OCamlMakefile to use
export OCAMLMAKEFILE = ./OCamlMakefile

SOURCES=higher.mli higher.ml

RESULT=higher

OCAMLFLAGS += $(shell ocamlc -bin-annot 2>/dev/null && echo -bin-annot)

LIBINSTALL_FILES := higher.mli higher.cmi \
                    higher.cma

LIBINSTALL_OPTIONAL_FILES := higher.cmt higher.cmti
NATIVE_LIBINSTALL_FILES := \
                    higher.cmx higher.cmxa higher.a

all: byte-code-library native-code-library

meta-install:
	$(OCAMLFIND) install higher META

byte-code-lib-install: byte-code-library
	ocamlfind install -add higher $(LIBINSTALL_FILES) \
           -optional $(LIBINSTALL_OPTIONAL_FILES)

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
