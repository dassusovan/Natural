/*
 * generated by Xtext
 */
package org.agileware.natural.cucumber.formatting2

import com.google.inject.Inject
import org.agileware.natural.cucumber.cucumber.Background
import org.agileware.natural.cucumber.cucumber.DocString
import org.agileware.natural.cucumber.cucumber.Example
import org.agileware.natural.cucumber.cucumber.Feature
import org.agileware.natural.cucumber.cucumber.Meta
import org.agileware.natural.cucumber.cucumber.Scenario
import org.agileware.natural.cucumber.cucumber.ScenarioOutline
import org.agileware.natural.cucumber.cucumber.Step
import org.agileware.natural.cucumber.cucumber.Table
import org.agileware.natural.cucumber.cucumber.Tag
import org.agileware.natural.cucumber.services.CucumberGrammarAccess
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.IFormattableDocument

/**
 * Each AST element has been given its own formatting directive so they can be individually
 * formatted on its own. As a consequence, each element should apply formatting rules
 * without any assumptions about elements not contained within its own node. This means,
 * for example, indentation rules should be applied by a parent node, and not the target node.
 * This will ensure formatting is preserved within the document as a whole, whilst formatting
 * individual elements.
 * 
 * TODO: There are still some cases where the above "law" is being violated. This will need
 *       to be fixed for formatting to work correctly.
 */
class CucumberFormatter extends AbstractFormatter2 {

	@Inject extension CucumberGrammarAccess

	def dispatch void format(Feature model, extension IFormattableDocument document) {
		// println(textRegionAccess)

		// format meta tags
		model.meta.format()

		// format narrative
		// TODO...
		// format background
		model.background.format()

		// format scenarios
		for (s : model.scenarios) {
			s.format()
		}

		println(document)
	}

	def dispatch void format(Meta model, extension IFormattableDocument document) {
		for (t : model.tags) {
			t.format()
		}
	}

	def dispatch void format(Tag model, extension IFormattableDocument document) {
		// TODO...
	}

	def dispatch void format(Background model, extension IFormattableDocument document) {

		// format steps
		// //
		val begin = model.regionFor.ruleCall(backgroundAccess.EOLTerminalRuleCall_3)
		val end = model.steps.last.regionFor.ruleCall(stepAccess.EOLTerminalRuleCall_2)
		interior(begin, end)[indent]

		for (s : model.steps) {
			s.format()
			s.prepend[indent]
		}
	}

	def dispatch void format(Scenario model, extension IFormattableDocument document) {

		// format meta tags
		model.meta.format()

		// format steps
		val begin = model.regionFor.ruleCall(scenarioAccess.EOLTerminalRuleCall_4)
		val end = model.steps.last.regionFor.ruleCall(stepAccess.EOLTerminalRuleCall_2)
		interior(begin, end)[indent]

		for (s : model.steps) {
			s.format()
			s.prepend[indent]
		}
	}

	def dispatch void format(ScenarioOutline model, extension IFormattableDocument document) {

		// format meta tags
		model.meta.format()

		// format steps
		// //
		val begin = model.regionFor.ruleCall(scenarioOutlineAccess.EOLTerminalRuleCall_4)
		val end = model.steps.last.regionFor.ruleCall(stepAccess.EOLTerminalRuleCall_2)
		interior(begin, end)[indent]

		for (s : model.steps) {
			s.format()
			s.prepend[indent]
		}

		// format examples
		for (e : model.examples) {
			e.format()
		}
	}

	def dispatch void format(Example model, extension IFormattableDocument document) {
		// format meta tags
		model.meta.format()

		// format table
		model.table.format()
	}

	def dispatch void format(Step model, extension IFormattableDocument document) {
		// format table | text
		if(model.table !== null) model.table.format()
		if(model.text !== null) model.text.format()
	}

	def dispatch void format(Table model, extension IFormattableDocument document) {
		// TODO...
	}

	def dispatch void format(DocString model, extension IFormattableDocument document) {
		// TODO...
	}

}
