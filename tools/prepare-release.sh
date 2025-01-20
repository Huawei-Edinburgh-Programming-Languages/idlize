#!/bin/bash

# Copyright (c) 2022-2023 Huawei Device Co., Ltd.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit -o nounset -o pipefail

if [[ $# -eq 0 ]]; then
    echo "USAGE: $0 <version>"
    exit 1
fi

version_file="./VERSION"
new_version=$1

check_before_running() {
    # Test VERSION file exists in cwd
    if ! [[ -f "$version_file" ]]; then
        echo "$version_file does not exist, make sure you are running this script from the repository root"
        exit 1
    fi

    # Can run only on master branch
    cur_branch=`git rev-parse --abbrev-ref HEAD`
    if [[ "$cur_branch" != 'master' ]]; then
        echo "Releases can be created only from the master branch"
        exit 1
    fi

    # Current version must not be equal to new version
    # TODO if current version is a.b.c new version must be a.b.(c+1) or a.(b+1).0 or (a+1).0.0
    current_version=`cat $version_file`
    if [[ $current_version == $new_version ]]; then
        echo "Can not create release of the same version"
        exit 1
    fi
}

update_version_in_file() {
    file=$1
    old=$2
    new=$3

    echo "  $file: $old -> $new"
    sed -i "s/$old/$new/" $file
    git add $file
}

update_versions() {
    version=`cat $version_file`
    version_short=${version%%-*}
    dev_version="$version_short+devel"
    dev_jar_version="$version_short-SNAPSHOT"
    new_version_short=${new_version%%-*}
    new_dev_version="$new_version_short+devel"
    new_dev_jar_version="$new_version_short-SNAPSHOT"

    files=(
        ./core/package.json
        ./linter/package.json
        ./package.json
    )

    echo "Upgrading $version -> $new_version"
    update_version_in_file $version_file $version $new_version
    for file in "${files[@]}"; do
        update_version_in_file $file $dev_version $new_dev_version
    done
    for file in "${jars[@]}"; do
        update_version_in_file $file $dev_jar_version $new_dev_jar_version
    done
}

create_branch() {
    release_branch="release-v.$new_version"
    git checkout -b $release_branch
    echo "Created branch $release_branch"
}

update_workspace_package_lock() {
    npm install --no-audit --no-fund
    git add package-lock.json
}

check_before_running
create_branch
update_versions
update_workspace_package_lock
# TODO git commit -m "Release v.$1"

echo "Release is ready, run" "  $ git commit -m 'Release v.$1'"
