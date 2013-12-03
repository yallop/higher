
OCAMLC=ocamlc
OCAMLOPT=ocamlopt
OCAMLFIND=ocamlfind

INSTALL=META higher.cmi higher.cmo higher.cmx higher.o

all: higher.cmo higher.cmx higher.cmi

higher.cmi : higher.mli
	${OCAMLC} -c higher.mli

higher.cmo : higher.ml higher.cmi
	${OCAMLC} -c higher.ml

higher.cmx higher.o : higher.ml higher.cmi
	${OCAMLOPT} -c higher.ml

install: all
	${OCAMLFIND} install higher ${INSTALL}

uninstall:
	${OCAMLFIND} remove higher

clean:
	rm higher.cmo
	rm higher.cmx
	rm higher.cmi
	rm higher.o
