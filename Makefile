#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

#
# Copyright (c) 2017, Joyent, Inc.
#

#
# Tools
#
TAPE :=			./node_modules/.bin/tape
NPM  :=			npm

include ./tools/mk/Makefile.defs
include ./tools/mk/Makefile.node_modules.defs

#
# Files
#
JSON_FILES =		package.json
JS_FILES :=		$(shell find lib test -name '*.js') tools/bashstyle
JSL_FILES_NODE =	$(JS_FILES)
JSSTYLE_FILES =		$(JS_FILES)

JSL_CONF_NODE =		tools/jsl.node.conf
JSSTYLE_FLAGS =		-f tools/jsstyle.conf

#
# Targets
#

.PHONY: all
all:
	$(NPM) install

.PHONY: test
test: $(STAMP_NODE_MODULES)
	$(NODE) $(TAPE) test/*.test.js

include ./tools/mk/Makefile.deps
include ./tools/mk/Makefile.node_modules.targ
include ./tools/mk/Makefile.targ
