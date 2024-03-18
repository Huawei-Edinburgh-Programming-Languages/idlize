if [ -d "ohos-sdk" ]; then
  exit
fi

echo "ohos-sdk doesnt exist, will download"
git clone https://gitee.com/openharmony/interface_sdk-js.git

mkdir ./ohos-sdk/
mkdir ./ohos-sdk/component/
cp -r ./interface_sdk-js/api/@internal/component/ets/. ./ohos-sdk/component/

rm -rf interface_sdk-js
