/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

/*
 * Copyright (c) 2017, Joyent, Inc.
 */

var xlog = require('../lib/index');
var verror = require('verror');
var test = require('tape').test;

test('invalid inputs (not xlog locations)', function (t) {
	t.throws(function () {
		xlog.xlogCompare('1', '2');
	/* JSSTYLED */
	}, /cannot compare "1" to "2"/);
	t.end();
});

test('compare OK', function (t) {
	var res = xlog.xlogCompare('2D7/0', '2D6/FEFFE770');

	t.equal(res, 1);
	t.end();
});
