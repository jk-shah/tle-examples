EXTENSION = demo
EXTVERSION = 1.0
EXTCOMMENT = "Demo 1.0 Extension using pg_tle"
DATA = demo--0.1,sql demo--1.0.sql demo--0.1--1.0.sql demo--1.0--1.1.sql
MODULE = demo

TAP_TEST = 1
REGRESS = $(EXTENSION)-test

USE_PGTLE = 1

ifdef USE_PGTLE
PGTLE = ../pgtle.mk
include $(PGTLE)
endif

