if [ -d "interface_sdk-js" ]; then
  exit
fi

echo "ohos-sdk doesnt exist, will download"
git clone https://gitee.com/openharmony/interface_sdk-js.git
