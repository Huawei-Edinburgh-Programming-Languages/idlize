if [ -d "ohos-sdk" ]; then
  exit
fi

echo "ohos-sdk doesnt exist, will download"
git clone https://gitee.com/openharmony/interface_sdk-js.git
