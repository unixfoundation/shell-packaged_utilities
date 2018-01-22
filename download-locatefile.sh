#!/usr/bin/env bash
# 
# File:
#   download-locatefile.sh
# 
# Description:
#   Download utility Locatefile in unixfoundation/shell.packaged-utilities
# 

# ======= CONFIGURATIONS ==============

# Directory where files will be downloaded
readonly DOWNLOAD_DIR="${HOME}"

# ======= ! CONFIGURATIONS ==============

readonly MASTER_URL='https://raw.githubusercontent.com/unixfoundation/shell.packaged-utilities/master'
readonly BASE_URL="${MASTER_URL}/locatefile"

readonly BASE_DIR="${DOWNLOAD_DIR}/shell.packaged-utilities/locatefile"

if [ ! -d "${DOWNLOAD_DIR}/shell.packaged-utilities" ]; then
  mkdir -p "${DOWNLOAD_DIR}/shell.packaged-utilities"
fi

echo -e "::Downloading files to ${BASE_DIR}\n  Please wait"

[ -d "${BASE_DIR}" ] && rm -Rf "${BASE_DIR}"
mkdir "${BASE_DIR}"
cd "${BASE_DIR}"

exec 3>&1 4>&2; exec >/dev/null 2>&1 # redirect all output to /dev/null

# ============================================
#   Download files from locatefile/
# ============================================

curl -O "${BASE_URL}/{CONFIGURATIONS.bash,locatefile,updatedb}"
chmod +x locatefile updatedb

path='/dirsdb'
mkdir "${BASE_DIR}${path}"
cd "${BASE_DIR}${path}"
curl -O "${BASE_URL}${path}/{mount-drive-1-paths,mount-drive-2-paths,"\
'home-paths}'

path='/filesdb'
mkdir "${BASE_DIR}${path}"
cd "${BASE_DIR}${path}"
curl -O "${BASE_URL}${path}/{mount-drive-1-paths,mount-drive-2-paths,"\
'home-paths}'


exec >&3 2>&4 # redirect all output back to /dev/tty
echo '::Finished'
