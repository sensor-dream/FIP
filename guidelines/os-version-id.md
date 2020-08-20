# OS VERSION ID

    FILE_OS_RELEASE="/etc/os-release"
    OS_VERSION_ID="$(grep VERSION_ID ${FILE_OS_RELEASE} | awk -F= '{ print $2 }')"
    or
    OS_VERSION_ID="$(rpm -E %fedora)"
    echo "${OS_VERSION_ID}
