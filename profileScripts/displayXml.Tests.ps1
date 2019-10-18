Describe 'Format-Xml' {
	It "Given a single, empty tag, the result is a single line." {
		$xml = "<someXml />"
		$Input = $xml | Format-Xml
		$Input | Should -Be "<someXml />"
	}

	It "Given nested tags, the result is indented." {
		$xml = "<someXml><nestedXml/></someXml>"
		$Input = $xml | Format-Xml
		$Input | Should -Be @("<someXml>", "`t<nestedXml/>", "</someXml>")
	}
}
