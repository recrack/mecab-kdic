all:
	./mk-corpus-dic-posid.rb
	cd seed && make && cd ../final && make

clean:
	rm -f corpus && \
	cd seed && make clean && cd ../final && make clean
