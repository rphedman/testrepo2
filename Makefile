COVDIR:=cov-int
TARG:=hello
.PHONY: covbuild

all: $(TARG)

test: all
	./$(TARG) test args

$(TARG): $(TARG).c
	cc -Wall -ggdb -Werror $^ -o $@

clean:
	rm -f $(TARG)
