Describe 'Where-String' {
    It "Given '<Collection>' and starts with '<StartsWith>', expected values are returned" -TestCases @(
        @{ Collection = @('Hello'); StartsWith = 'Hello'; Expected = @('Hello'); },
        @{ Collection = @('Hello', 'Hey'); StartsWith = 'He'; Expected = @('Hello', 'Hey'); },
        @{ Collection = @('Hello'); StartsWith = 'NotHello'; Expected = @(); },
        @{ Collection = @('Hello', 'Hey'); StartsWith = 'NotHe'; Expected = @(); }
    ) {
        param ($StartsWith, $Expected, $Collection)

        $result = $Collection | Where-String -StartsWith $StartsWith
        $result | Should -Be $Expected
    }

    It "Given '<Collection>' and contains '<Contains>', expected values are returned" -TestCases @(
        @{ Collection = @('Hello'); Contains = 'll'; Expected = @('Hello'); },
        @{ Collection = @('Hello'); Contains = 'le'; Expected = @(); },
        @{ Collection = @('Hello', 'Hey'); Contains = 'He'; Expected = @('Hello', 'Hey'); },
        @{ Collection = @('Hello', 'Hey'); Contains = 'Not'; Expected = @(); }
    ) {
        param ($Contains, $Expected, $Collection)

        $result = $Collection | Where-String -Contains $Contains
        $result | Should -Be $Expected
    }

    It "Given '<Collection>', contains '<Contains>', and starts with '<StartsWith>', expected values are returned" -TestCases @(
	@{ Collection = @('Hello'); Contains = 'll'; StartsWith = 'He'; Expected = @('Hello'); }
	@{ Collection = @('Hello'); Contains = 'mm'; StartsWith = 'Be'; Expected = @(); }
	@{ Collection = @('Hello', 'Yellow'); Contains = 'll'; StartsWith = 'He'; Expected = @('Hello'); }
	@{ Collection = @('Hello', 'Hey'); Contains = 'll'; StartsWith = 'He'; Expected = @('Hello'); }
    ) {
        param ($StartsWith, $Contains, $Expected, $Collection)

        $result = $Collection | Where-String -Contains $Contains -StartsWith $StartsWith
        $result | Should -Be $Expected
    }
}
