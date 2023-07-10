
PROG_NAME = prog
PROG_NAME_DEBUG = $(PROG_NAME)

SRC_DIR = src
SRC_FILES = main.c
FULL_SRC_FILES = $(patsubst %.c,$(SRC_DIR)/%.c, $(SRC_FILES))

PACKAGES ?=
PKGCONFIG = pkg-config
COMPILER_FLAGS = -std=c99 -Wall
CFLAGS = $(if $(PACKAGES), shell $(PKGCONFIG) --cflags $(PACKAGES),)
LIBS = $(if $(PACKAGES), shell $(PKGCONFIG) --libs $(PACKAGES),)

all: release

release: $(FULL_SRC_FILES)
	$(CC) \
		$(FULL_SRC_FILES) \
		$(COMPILER_FLAGS) \
		$(CFLAGS) \
		$(LIBS) \
		-o $(PROG_NAME)

debug: $(FULL_SRC_FILES)
	$(CC) \
		--verbose -g \
		$(FULL_SRC_FILES) \
		$(COMPILER_FLAGS) \
		$(CFLAGS) \
		$(LIBS) \
		-o $(PROG_NAME)

clean:
	$(RM) *.o *.so $(PROG_NAME) $(PROG_NAME_DEBUG) core*

.PHONY: all clean
