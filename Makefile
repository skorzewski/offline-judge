ALL_BIN_FILES=$(subst .c,,$(shell ls *.c))
ALL_EXP_FILES=$(subst .c,.exp,$(shell ls ??????.c))
ALL_DIFF_FILES=$(subst .c,.diff,$(shell ls ????????????.c))
ALL_FAIL_FILES=$(subst .c,.fail,$(shell ls ??????.c))

all: bin exp test fail

bin: $(ALL_BIN_FILES)

exp: $(ALL_EXP_FILES)

test: $(ALL_DIFF_FILES)

fail: $(ALL_FAIL_FILES)

%: %.c
	gcc $< -o $@

%.exp: %.in %
	while read line; do echo $${line} | ./$*; done <$< >$@

%.ou: %
	$(eval INFILE := $(shell echo $* | sed 's/[0-9][0-9][0-9][0-9][0-9][0-9]$$/.in/'))
	while read line; do echo $${line} | ./$*; done <$(INFILE) >$@

%.diff: %.ou
	$(eval EXPFILE := $(shell echo $< | sed 's/[0-9][0-9][0-9][0-9][0-9][0-9][.]ou$$/.exp/'))
	diff $< $(EXPFILE) >$@

%.fail: %
	./show_failures.sh $* >$@

.PRECIOUS: %.ou

.PHONY: clean

clean:
	rm -f *.fail
	rm -f *.diff
	rm -f *.ou
	rm -f *.exp
	rm -f ????????????
	rm -f ??????
