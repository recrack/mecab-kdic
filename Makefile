all:
	./pos-id-gen.rb > ./seed/pos-id.def && \
        ./pos-id-gen.rb > ./final/pos-id.def && ./mk-corpus-dic.rb
	cd seed && make && cd ../final && make

clean:
	rm -f corpus && \
	cd seed && make clean && cd ../final && make clean
