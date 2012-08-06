all:
	./pos-id-gen.rb > ./seed/pos-id.def && ./pos-id-gen.rb > ./final/pos-id.def && ./csv-gen.rb > ./seed/kdic.csv
	cd seed && make && cd ../final && make

clean:
	cd seed && make clean && cd ../final && make clean
