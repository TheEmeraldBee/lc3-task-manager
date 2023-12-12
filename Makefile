build: build-main build-int build-str build-task build-new-task build-delete-task build-util build-printn build-save build-data

run: build
	cd build && \
	lc3simulator \
	int_input.obj \
	string_input.obj \
	task.obj \
	new_task.obj \
	delete_task.obj \
	util.obj \
	printn.obj \
	save.obj \
	data.obj \
	main.obj

build-main:
	lc3assembler main.asm &&\
	mv main.obj build/main.obj

build-int:
	lc3assembler int_input.asm &&\
	mv int_input.obj build/int_input.obj

build-str:
	lc3assembler string_input.asm &&\
	mv string_input.obj build/string_input.obj

build-task:
	lc3assembler task.asm &&\
	mv task.obj build/task.obj

build-new-task:
	lc3assembler new_task.asm &&\
	mv new_task.obj build/new_task.obj

build-delete-task:
	lc3assembler delete_task.asm &&\
	mv delete_task.obj build/delete_task.obj

build-util:
	lc3assembler util.asm &&\
	mv util.obj build/util.obj

build-printn:
	lc3assembler printn.asm &&\
	mv printn.obj build/printn.obj

build-save:
	lc3assembler save.asm &&\
	mv save.obj build/save.obj

build-data:
	lc3assembler data.asm &&\
	mv data.obj build/data.obj
