function make_isbn10(isbn13) {
	# 1-based index
	isbn9 = substr(isbn13, 4, 9);

	sum = 0;
	sum += substr(isbn9, 1, 1) * 10;
	sum += substr(isbn9, 2, 1) *  9;
	sum += substr(isbn9, 3, 1) *  8;
	sum += substr(isbn9, 4, 1) *  7;
	sum += substr(isbn9, 5, 1) *  6;
	sum += substr(isbn9, 6, 1) *  5;
	sum += substr(isbn9, 7, 1) *  4;
	sum += substr(isbn9, 8, 1) *  3;
	sum += substr(isbn9, 9, 1) *  2;
	sum = (11 - sum % 11) % 11;

	isbn10 = isbn9 (sum == 10 ? "X" : sum);

	return isbn10;
}

BEGIN {
	FS = "\t";
	OFS = "\t";
}

{
	isbn = $1;
	if (isbn != "#N/A") {
		gsub(/-/, "", isbn);
		if (length(isbn) == 13) {
			isbn = make_isbn10(isbn);
		} else if (length(isbn) != 10) {
			exit 1;
		}
	}

	date = $2
	gsub(/-/, "/", date);

	print isbn, date, $3, $4;
}
