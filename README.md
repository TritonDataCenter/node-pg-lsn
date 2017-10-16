<!--
    This Source Code Form is subject to the terms of the Mozilla Public
    License, v. 2.0. If a copy of the MPL was not distributed with this
    file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->

<!--
    Copyright (c) 2017, Joyent, Inc.
-->

# node-pg-lsn

Constants and functions for working with postgres xlog positions.  This module
makes a number of assumptions about the format of xlog positions.  It's not
totally clear that this is a committed Postgres interface, but it seems to be
true.

We assume that postgres xlog positions are represented as strings of the
form:

    filepart/offset		e.g., "0/17BB660"

where both "filepart" and "offset" are hexadecimal numbers.  xlog position
F1/O1 is at least as new as F2/O2 if (F1 > F2) or (F1 == F2 and O1 >= O2).
We try to avoid assuming that they're zero-padded (i.e., that a simple string
comparison might do the right thing).  We also don't make any assumptions
about the size of each file, which means we can't compute the actual
difference between two positions.

## Usage

    var assert = require('assert');
    var lsn = require('pg-lsn');

    var locationOne = '2D7/0';
    var locationTwo = '2D6/FEFFE770';
    var comparison = lsn.xlogCompare(locationOne, locationTwo);

    if (comparison === 0) {
        console.log('locations are the same');
    } else if(comparison > 0) {
        console.log('locationOne is greater than locationTwo');
    } else {
        assert.ok(comparison < 0);
        console.log('locationOne is less than locationTwo');
    }
