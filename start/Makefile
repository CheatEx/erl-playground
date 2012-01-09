
.SUFFIXES: .erl .beam .yrl

.erl.beam:
	erlc -W $<

.yrl.erl:
	erlc -W $<

ERL = erl -boot start_clean

MODS = starter starter_test

all: compile

compile: ${MODS:%=%.beam}

run: compile
	${ERL} -pa . -s starter_test run_test

clean:
	rm -rf *.beam erl_crash.dump

