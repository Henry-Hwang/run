#!/bin/bash

cd ~/workspace/d/svn/x30-l2
repo sync
source build/envsetup.sh && lunch full_mz6799_6m_v2_n-eng
make update-api
make -j8

source build/envsetup.sh && lunch full_mz6799_6m_v2_2k_n-eng
make update-api
make -j8

cd ~/workspace/M1792-BK
git init
git add --all
git commit -m "Codebase D +"

cd ~/workspace/M1792
repo sync
rm -fr .repo
find ./ -name .git -type d | xargs rm -fr
find ./ -name *.git* -type f | xargs rm -fr
cp -fr * ~/workspace/M1792-BK
cp ~/workspace/M1792-BK/external/iw/version.sh ~/workspace/M1792-BK/external/iw/version.sh

cd ~/workspace/M1792-BK
git add --all
git commit -m "Codebase E"

source build/envsetup.sh && lunch full_mz6799_6m_v2_n-eng
make update-api
make -j8
