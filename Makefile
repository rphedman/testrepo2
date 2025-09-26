COVTAR:=testrepo2.tgz
COVDIR:=cov-int
TARG:=hello
.PHONY: covbuild covtar covsubmit

all: $(TARG)

test: all
	./$(TARG) test args

$(TARG): $(TARG).c
	cc -Wall -ggdb -Werror $^ -o $@

clean:
	rm -f $(TARG)

distclean: clean
	rm -rf $(COVTAR) $(COVDIR)

covbuild: clean
	cov-build --dir $(COVDIR) make

$(COVTAR): covbuild
	tar zcf $(COVTAR) $(COVDIR)

covtar: $(COVTAR)

covsubmit: $(COVTAR)
	curl --form token=ieTwgvxfyU-Lh924rHSPrg \
	     --form email=gumby@hedman.ca \
	     --form file=@$(COVTAR) \
	     --form version="1.0" \
	     --form description="Testrepo2" \
	     https://scan.coverity.com/builds?project=gumbyhedman%2Ftestrepo2
