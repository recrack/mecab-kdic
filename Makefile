all:
	./mk-corpus-dic.rb
	cd seed && make && cd ../final && make

clean:
	rm -f corpus && \
	cd seed && make clean && cd ../final && make clean
