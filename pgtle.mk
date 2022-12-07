# PGTLE: Trusted Language Extensions makefile

# pgtle.mk

# The source of inspiration is the PGXS makefile to keep similar look and feel


# This file contains generic rules to build many kinds of simple
# extension modules.  You only need to set a few variables and include
# this file, the rest will be done here.
#
# Use the following layout for your Makefile:
#
#   [variable assignments, see below]
#
#   PGTLE := $(shell which pgtle.mk)
#   include $(PGTLE)
#
#   [custom rules, rarely necessary]
#
# Set all of these three variables to specify what is built:
#
#   EXTENSION -- Extension name
#   EXTVERSION -- Extension default version
#   EXTCOMMENT -- Extenion Default comment
#
# The following variables can also be set:
#
#   DATA -- list of files denoting various other versions and upgrade paths
#
# Better look at some of the existing uses for examples...


ENVFILE = ../env

init:
ifeq (,$(wildcard ./glob.c))
	cp $(ENVFILE).ini $(ENVFILE)
endif

PSQL := source $(ENVFILE) && psql -d $(PGDB) -U $(PGUSER) -h $(PGHOST)

ifneq (,$(EXTENSION))
EXTCONTENT := $(shell cat $(EXTENSION)--$(EXTVERSION).sql)
define TLE_INSTALL
SELECT pgtle.install_extension(
'$(EXTENSION)',
'$(EXTVERSION)',
'$(EXTCOMMENT)',
$$_pgtle_$$
$(EXTCONTENT)
$$_pgtle_$$
);
endef
export TLE_INSTALL 
endif # EXTENSION


ifneq (,$(DATA))
UPGRADES := $(notdir $(wildcard ./*--*--*.sql))
INSTALL := $(filter-out $(UPGRADES), $(notdir $(wildcard ./*--*.sql)))
INSTALL := $(filter-out $(EXTENSION)--$(EXTVERSION).sql, $(INSTALL))
UNINSTALL := $(INSTALL)

#$(foreach )

endif # DATA


.PHONY: install uninstall test clean
install:
ifneq (,$(EXTENSION))
	echo "$$TLE_INSTALL" > pgtle-$(EXTENSION).sql
	$(PSQL) -f pgtle-$(EXTENSION).sql
endif
ifneq (,$(DATA))
	echo "Install:" $(INSTALL)
	echo "Upgrades:" $(UPGRADES)
endif # DATA


uninstall:
ifneq (,$(EXTENSION))
	$(PSQL) -c  "SELECT pgtle.uninstall_extension( '$(EXTENSION)' )"
endif
ifneq (,$(DATA))
	echo "Uninstall:" $(INSTALL)
endif # DATA

test:
	$(PSQL) -f sql/$(EXTENSION)-test.sql

clean:
# things created by various check targets
	rm -rf pgtle-$(EXTENSION).sql
