all:
	/usr/lib/mecab/mecab-dict-index -p -d . -c UTF-8 -t UTF-8 -f UTF-8
	/usr/lib/mecab/mecab-cost-train -c 1.0 corpus model
	/usr/lib/mecab/mecab-dict-gen -o ../final -m model

clean:
	rm -f *.dic *.bin model model.txt pos-id.def kdic.csv
