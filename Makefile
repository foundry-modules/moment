all: modularize-script minify-script create-script-folder locale

include ../../build/modules.mk

MODULE = moment
SOURCE_SCRIPT_FILE_PREFIX =
SOURCE_SCRIPT_FOLDER = .

locale:
	for locale in lang/*.js ; do \
		echo $$locale | sed 's/lang\///' | xargs make ; \
	done

%.js:
	cat lang/$*.js | sed 's/require(\'\''..\/moment'\'')/\$$\.moment/g' > ${TARGET_SCRIPT_FOLDER}/$*.js
	${MODULARIZE} -n "moment/$*" -o "${TARGET_SCRIPT_FOLDER}/$*.raw.js" ${TARGET_SCRIPT_FOLDER}/$*.js
	mv "${TARGET_SCRIPT_FOLDER}/$*.raw.js" ${TARGET_SCRIPT_FOLDER}/$*.js
	${UGLIFYJS} ${TARGET_SCRIPT_FOLDER}/$*.js > ${TARGET_SCRIPT_FOLDER}/$*.min.js


  