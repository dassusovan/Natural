package org.agileware.natural.cucumber.tests;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({ 
		CucumberExamplesTest.class, 
		CucumberParsingTest.class, 
		CucumberSerializerTest.class,
		CucumberValidationTest.class 
})
public class CucumberTestSuite {

}
