/*
 * generated by Xtext
 */
package org.agileware.natural.jbehave.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith

import static org.agileware.natural.jbehave.jbehave.StepStartingWord.*
import static org.agileware.natural.jbehave.tests.JbehaveTestHelpers.*
import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.Matchers.*

@RunWith(XtextRunner)
@InjectWith(JbehaveInjectorProvider)
class JbehaveParsingTest {
	
	@Inject JbehaveTestHelpers _th
	
	@Test
	def void narrativeTypeA() {
		val model = _th.parse('''
			Narrative:
			In order to sell a pet
			As a store owner
			I want to add a new pet to the catalog
		''')
		
		assertThat(model, notNullValue())
		_th.trace("narrativeTypeA", model)

		assertThat(model, hasNarrative(
			inOrderTo("sell a pet"),
			asA("store owner"),
			iWantTo("add a new pet to the catalog")
		))
	}
	
	@Test
	def void narrativeTypeB() {
		val model = _th.parse('''
			Narrative:
			As a store owner
			I want to add a new pet to the catalog
			So that the pet gets sold
		''')
		
		assertThat(model, notNullValue())
		_th.trace("narrativeTypeB", model)
		
		assertThat(model, hasNarrative(
			asA("store owner"),
			iWantTo("add a new pet to the catalog"),
			soThat("the pet gets sold")
		))
	}
	
	@Test
	def void narrativeWithDescriptionAndMeta() {
		val model = _th.parse('''
			The quick brown fox
			Jumps over the lazy dog
			
			Meta:
			@author Mauro
			@themes UI Usability
			
			Narrative:
			In order to sell a pet
			As a store owner
			I want to add a new pet to the catalog
		''')
		
		assertThat(model, notNullValue())
		_th.trace("narrativeWithDescriptionAndMeta", model)
		
		assertThat(model.description, notNullValue())
		assertThat(model.description.lines, hasSize(2))
		assertThat(model.meta, notNullValue())

		assertThat(model, hasNarrative(
			inOrderTo("sell a pet"),
			asA("store owner"),
			iWantTo("add a new pet to the catalog")
		))
	}
	
	@Test
	def void simpleScenarios() {
		val model = _th.parse('''
			Narrative:
			In order to communicate effectively to the business some functionality
			As a development team
			I want to use Behaviour-Driven Development
			
			Scenario: A scenario is a collection of executable steps of different type
			
			Given step represents a precondition to an event
			When step represents the occurrence of the event
			Then step represents the outcome of the event
			
			Scenario: Another scenario exploring different combination of events
			 
			Given a [precondition]
			When a negative event occurs
			Then the outcome should <be-captured>
			 
			Examples: 
			|precondition|be-captured|
			|abc|be captured    |
			|xyz|not be captured|
		''')
		
		assertThat(model, notNullValue())
		_th.trace("simpleScenarios", model)
		
		assertThat(model, hasNarrative(
			inOrderTo("communicate effectively to the business some functionality"),
			asA("development team"),
			iWantTo("use Behaviour-Driven Development")
		))
		
		assertThat(model.scenarios, hasSize(2))
		
		val s1 = model.scenarios.get(0)
		assertThat(s1.title, equalTo("A scenario is a collection of executable steps of different type"))
		assertThat(s1.steps, hasItems(
				theStep(GIVEN, "step represents a precondition to an event"),
				theStep(WHEN, "step represents the occurrence of the event"),
				theStep(THEN, "step represents the outcome of the event")
		))
		
		val s2 = model.scenarios.get(1)
		assertThat(s2.title, equalTo("Another scenario exploring different combination of events"))
		assertThat(s2.steps, hasItems(
				theStep(GIVEN, "a [precondition]"),
				theStep(WHEN, "a negative event occurs"),
				theStep(THEN, "the outcome should <be-captured>")
		))
	}
	
	@Test
	def void allSupportedSyntax() {
		val model = _th.parse(EXAMPLE_STORY)
		
		assertThat(model, notNullValue())
		_th.trace("allSupportedSyntax", model)
		
		assertThat(model.eResource.errors, empty())
	}
}
