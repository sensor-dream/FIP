#!/bin/bash

function usage {
  echo "--- inttf NVIDIA patcher ---"
  echo "script usage: $(basename $0) [-h] [-v 340.108, 390.138, 418.113 or 435.21]" >&2
}

function get_opts {
  local OPTIND
  while getopts "hv:" opt; do
    case $opt in
      v) 
        nvidia_version=$OPTARG
        ;;
      h)
        usage
        exit 0
        ;;
      *) 
        usage
        exit 1
        ;;
      \?)
        usage
        exit 1
        ;;
    esac
  done
  if [ $OPTIND -eq 1 ]; then 
    usage
    exit 1;
  fi
}

function check_version {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  usage
  exit 1;
}

function check_file {
  if [ ! -f ./$1 ]; then
    echo Downloading... $2
    wget -O $1 $2
  else
    echo $1 found.
  fi
  if [ "$(b2sum < ./$1)" = "$3  -" ]; then
    echo $1 [OK]
  else
    echo $1 [Fail]
    exit 1
  fi
}

get_opts "$@"

nvidia_versions=( '340.108' '390.138' '418.113' '435.21' )

check_version $nvidia_version "${nvidia_versions[@]}"

nvidia_short_ver=${nvidia_version%.*}
nvidia_directory="NVIDIA-Linux-x86_64-${nvidia_version}"
nvidia_file="NVIDIA-Linux-x86_64-${nvidia_version}.run"
nvidia_url="https://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_version}/${nvidia_file}"
nvidia_340xx_b2sum="890d00ff2d1d1a602d7ce65e62d5c3fdb5d9096b61dbfa41e3348260e0c0cc068f92b32ee28a48404376e7a311e12ad1535c68d89e76a956ecabc4e452030f15"
nvidia_390xx_b2sum="5e6a9d77dd2b9de17d923198105a9227ffe2adbc1ed7c9dd5ef3cc810358f71ae47ce9615cbe04f36090f052082a2066772505fd763cbfdbce272f0fb7c25dc7"
nvidia_418xx_b2sum="b335f6c59641ee426aff2b05a495555ec81455a96c629727d041674f29bd4b5e694217ea9969ccf5339038c5a923f5baf5888491554a0ca20d6fc81faaaf8a27"
nvidia_435xx_b2sum="e9afd6335182a28f5136dbef55195a2f2d8f768376ebc148190a0a82470a34d008ce04170ffc1aab36585605910c1300567a90443b5f58cb46ec3bff6ab9409c"
nvar=nvidia_${nvidia_short_ver}xx_b2sum
nvidia_b2sum=${!nvar}

patch_url="https://nvidia.if-not-true-then-false.com/patcher/NVIDIA-${nvidia_short_ver}xx/"

case "${nvidia_short_ver}" in
  340)
    patch_file_names=( 'kernel-5.7.patch' 'kernel-5.8.patch' 'kernel-5.9.patch' )
    patch_file_b2sums=( '7150233df867a55f57aa5e798b9c7618329d98459fecc35c4acfad2e9772236cb229703c4fa072381c509279d0588173d65f46297231f4d3bfc65a1ef52e65b1' 'b436095b89d6e294995651a3680ff18b5af5e91582c3f1ec9b7b63be9282497f54f9bf9be3997a5af30eec9b8548f25ec5235d969ac00a667a9cddece63d8896' '947cb1f149b2db9c3c4f973f285d389790f73fc8c8a6865fc5b78d6a782f49513aa565de5c82a81c07515f1164e0e222d26c8212a14cf016e387bcc523e3fcb1' )
    ;;
  390)
    patch_file_names=( 'kernel-5.8.patch' 'kernel-5.9.patch' 'license.patch' )
    patch_file_b2sums=( '31e9c4a98bc776a691883c765cc97662ef4d29ab917452e23a6284a2d2b0f1ede2dd532fbd39b88d0c3a8b54ab8fd3926ef9d777ea19ed1748c9c659b9f5c1d9' 'f955b3d0140b838fc6de56699404318b4d4249d2cdcc03c118aef2068f5c14c51c78b873ead0ff636ccadc9b59b3aced27a74cc29b53da8d99e4455e218d7c25' '8c4d6b053bd676a5cbb7c591a3761e30d1ee1552be301450f203d6b8c737816d9033eb8732dce2fa8e36a9c725c95c5bfbc924c70ea28d5efbd84d1e93afb986' )
    ;;
  418)
    patch_file_names=( 'kernel-5.5.patch' 'kernel-5.6.patch' 'kernel-5.7.patch' 'kernel-5.8.patch' 'kernel-5.9.patch' 'license.patch' )
    patch_file_b2sums=( 'fae57c950f4906fa95801c2676cb9c4fd831c9e1c5333223fb68f3fb7dbb994742873ae307723eb0d7547a4a4c655d3bacb7e4d7e8e0f11051300fdb1098489a' 'b45a707f09feb32fd17df9e2582ef1ae77a4a21e6fcc51abc81d59c7e5e831c1c5fbcd3f06829fc084bed4a4ee3fdcbfc88ac2ba8a28d3c48d66ea539e490feb' 'e290a02036cb4a41b8c561aa9ad67971392550de9c4fd4f8106848752068fd544f48ae07736e40313bc71a9f8beee9f9a9b317e8931a686ccb9cf4af9ecc4430' '4241170d7ab8eda68b51893090c7ba2dffab1bc6316affa84aa2786a5f428874b9008febda8f20a761e08c1c79d962547e577fc59f2db97b42434fc76588aad6' '4bcd4094bab3349fbf4d784f5aaa6137930089d6e228f2adb86e960f2fd4ebe84c750f1c39e47f0d5372434b6f429a3a5921a7a590a4b4000a4b8d88d7583b06' '0472598d8ce4c60a93ef9843ab01b1ab99a647882e55ee2d666b6e10b2a43fabcee6a0d26f4674e224430c4af0ef9af5a4f277ad4e0ef2d13f5c30afe85100b3' )
    ;;
  435)
    patch_file_names=( 'kernel-5.4.patch' 'kernel-5.5.patch' 'kernel-5.6.patch' 'kernel-5.7.patch' 'kernel-5.8.patch' 'kernel-5.9.patch' 'license.patch' )
    patch_file_b2sums=( '586982cdbbb7751dc75f9b1c33ca033703170d0329c9c19e02bc32df732b6d7f102c5f703f8e4ec3a7152cb5a6ce87e0ed0fd3df95b040655b409ad59e0c210d' '26bdf3240caf5a8382703e9193e43993c518dcba325679f2e314d9ab69f7f11400d1fe0e4f99618bd1eaacb737143f37eedce363acfb78a5631c2bfc9a2e9150' 'e7b6ea3fae0bd92bdc0a934466313a48075b8e11b27cbdec328ec3bcb415d2c89aaf61cb0dc5506aaceb537162e8f833e55607a4db12ab3a6475f3b8ac736bff' 'e4ad99e110bbd8539b9ebf5ec5269db5db1ae2bc23b0fd6c1a2cb396b782a48a849c98de4a535327dc8cb2e73e50aad79e3fc2cb4d2b806cecc7c23aa06aa466' 'e77dfd9aa5629a66e8cfacb3afde1ef74b26f6471287b43b6e0fc58bb4686cab919a49ba2e9a6f931b4f443e49bf82ee759067a7c7477a965aa9295b223d8217' '7c5e6c9b37965c1e35fa35b99c8497afa50fd5e72f3494b02654e85b96e9982193e7a27d3b681c6b9de59f54bb5708950d3dc2640aa2a22ab4cc40e3163d42c9' 'badf91ac5b0d0ef5d5eda85b79447b475216b4692b19380f495670c961baa0b6f0d6687d2393c29edc22115f40e94705e488471265d30124b0a0775105638756' )
    ;;
esac

check_file $nvidia_file $nvidia_url $nvidia_b2sum

mkdir -p NVIDIA-${nvidia_short_ver}xx

for i in "${!patch_file_names[@]}"; do
  #echo ${patch_file_names[$i]} $patch_url ${patch_file_b2sums[$i]}
  check_file "NVIDIA-${nvidia_short_ver}xx/${patch_file_names[$i]}" "$patch_url${patch_file_names[$i]}" ${patch_file_b2sums[$i]}
done

chmod +x ./$nvidia_file

if [ -d ./$nvidia_directory ]; then
  rm -rf ./$nvidia_directory
fi

./$nvidia_file --extract-only

cd ./$nvidia_directory

for f in "${patch_file_names[@]}"; do
  patch -Np1 -i ../NVIDIA-${nvidia_short_ver}xx/$f
done

cd ..

./$nvidia_directory/makeself.sh --target-os Linux --target-arch x86_64 $nvidia_directory $nvidia_directory-patched-kernel-5.9.run "NVIDIA driver $nvidia_version patched for kernel 5.9+" ./nvidia-installer

exit 0





