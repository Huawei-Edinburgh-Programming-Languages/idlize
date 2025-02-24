npm run compile
node . \
    --use-new-ohos \
    --default-idl-package $3 \
    --dts2peer \
    --input-files ./tests/ohos-subset/ets/regression/dts/$1 \
    --output-dir ./out/test \
    --language $2 \
    # --options-file ./generator-config-test.json