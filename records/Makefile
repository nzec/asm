all: records_write records_read add_year

add_year: add_year.o record_read.o record_write.o error_exit.o count_chars.o write_newline.o
	ld add_year.o record_read.o record_write.o error_exit.o count_chars.o write_newline.o -o add_year

records_read: records_read.o record_read.o count_chars.o write_newline.o
	ld records_read.o record_read.o count_chars.o write_newline.o -o records_read

records_write: record_write.o records_write.o
	ld record_write.o records_write.o -o records_write

add_year.o: add_year.s linux.s record_def.s
	as add_year.s -o add_year.o

records_read.o: records_read.s linux.s record_def.s
	as records_read.s -o records_read.o

record_read.o: record_read.s linux.s record_def.s
	as record_read.s -o record_read.o

records_write.o: records_write.s linux.s record_def.s
	as records_write.s -o records_write.o

record_write.o: record_write.s linux.s record_def.s
	as record_write.s -o record_write.o

test_count_chars: count_chars.o test_count_chars.c
	cc test_count_chars.c count_chars.o -o test_count_chars

error_exit.o: error_exit.s linux.s
	as error_exit.s -o error_exit.o

count_chars.o: count_chars.s
	as count_chars.s -o count_chars.o

write_newline.o: write_newline.s linux.s
	as write_newline.s -o write_newline.o

clean:
	rm -f write_newline.o count_chars.o error_exit.o test_count_chars record_write.o records_write.o record_read.o records_read.o add_year.o records_write records_read add_year *.dat
