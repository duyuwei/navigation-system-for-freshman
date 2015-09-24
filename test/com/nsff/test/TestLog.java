package com.nsff.test;

import static org.junit.Assert.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;

public class TestLog {

	@Test
	public void test() {
		Log log = LogFactory.getLog(getClass());
		log.debug("debugr日志");
	}

}
