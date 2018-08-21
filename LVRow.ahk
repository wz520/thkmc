; Use with "for loop" to enumerate each selected line of a ListView control in an AHK GUI
class LVRow {
	_NewEnum() {
		return new CLVRowEnumerator()
	}
}
class CLVRowEnumerator {
	__New(  ) {
		this.first := True
		this.count := 0  ; how many times Next() has been called
	}
	Next(ByRef c, ByRef row) {
		if (this.first) {
			this.Remove("first")
			row := 0
		}

		row := LV_GetNext(row)
		result := row != 0
		if ( result ) {
			++this.count
		}
		c := this.count
		return result
	}
}

