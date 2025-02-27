run:
	cd tape && ./run.sh
	cd reel && ./run.sh

release:
	zip release.zip \
		tape/config.txt \
		tape/tape.pkm \
		reel/atlas.pkm \
		reel/atlas.txt
	cat names.txt | zipnote -w release.zip

clean:
	-rm release.zip
	-rm tape/*.pkm
	-rm reel/*.pkm
