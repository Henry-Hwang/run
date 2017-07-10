#Linux Tool
##Rename Terminal Tab
~~~script
function terminal-tab-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}s
}
~~~
##Combin several commit to one commit
47df5d + 7b8f9b -----> one
~~~script
sep@sep-Inspiron-7559:~/workspace/M1781/amss$ git log
commit 47df5d8ab75bb63765ac8c00c1e27a3cfd77a19b
Author: 钟庆龙 <loonzhong@meizu.com>
Date:   Thu Jun 1 20:48:58 2017 +0800

    OSPL: Move ospl to new place and Correct I2S port
          Remove SPACE at the end of lines

commit 7b8f9b5664ed1dafe377a7b8d652822c462c5f88
Author: 钟庆龙 <loonzhong@meizu.com>
Date:   Wed May 31 16:56:53 2017 +0800

    OSPL: Add lib, config ADSP for OSPL
    
    Signed-off-by: 钟庆龙 <loonzhong@meizu.com>

commit 5baf27b6a1312e041fc44e7d5e48abb30c019889
Author: konglingwei <konglingwei@meizu.com>
Date:   Mon May 29 21:17:09 2017 +0800

    [SCM]chipcode构建脚本
    
    Change-Id: I8fb37a443d1ea19a8aa181d5db04e8fac4fee116
~~~
One command line only
~~~script
#其中，-i 的参数是不需要合并的 commit 的 hash 值，这里指的是第一条 commit， 接着我们就进入到 vi 的编辑模式
git rebase -i 5baf27b6a1312e041fc44e7d5e48abb30c019889
~~~

~~~script
pick 7b8f9b5 OSPL: Add lib, config ADSP for OSPL
pick 47df5d8 OSPL: Move ospl to new place and Correct I2S port       Remove SPACE at the end of lines

# Rebase 5baf27b..47df5d8 onto 5baf27b (2 command(s))
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
# d, drop = remove commit
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
~~~
VIM modify
~~~scrip

pick 7b8f9b5 OSPL: Add lib, config ADSP for OSPL
squash 47df5d8 OSPL: Move ospl to new place and Correct I2S port       Remove SPACE at the end of lines

# Rebase 5baf27b..47df5d8 onto 5baf27b (2 command(s))
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
# d, drop = remove commit
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out

~~~
~~~script
# This is a combination of 2 commits.
# The first commit's message is:

OSPL: Add lib, config ADSP for OSPL

Signed-off-by: 钟庆龙 <loonzhong@meizu.com>

# This is the 2nd commit message:

OSPL: Move ospl to new place and Correct I2S port
      Remove SPACE at the end of lines

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Date:      Wed May 31 16:56:53 2017 +0800
#
# interactive rebase in progress; onto 5baf27b
# Last commands done (2 commands done):
#    pick 7b8f9b5 OSPL: Add lib, config ADSP for OSPL
#    squash 47df5d8 OSPL: Move ospl to new place and Correct I2S port       Remove SPACE at the end of lines
# No commands remaining.
# You are currently editing a commit while rebasing branch 'cirrus' on '5baf27b'.
#
# Changes to be committed:
#       new file:   ADSP.VT.4.0/adsp_proc/avs/afe/algos/opalum/build/avs_libs/qdsp6/660.adsp.prod/capi_v2_opalum_strip.lib
#       new file:   ADSP.VT.4.0/adsp_proc/avs/afe/algos/opalum/build/opalum.scons
#       new file:   ADSP.VT.4.0/adsp_proc/avs/afe/algos/opalum/capi_v2_opalum/build/capi_v2_opalum.scons
#       new file:   ADSP.VT.4.0/adsp_proc/avs/afe/algos/opalum/capi_v2_opalum/inc/capi_v2_opalum_ext.h
#       modified:   ADSP.VT.4.0/adsp_proc/avs/afe/services/static/src/AFEPortAprHandler.cpp
#       modified:   ADSP.VT.4.0/adsp_proc/avs/api/afe/inc/adsp_afe_service_commands.h
#       modified:   ADSP.VT.4.0/adsp_proc/avs/build/sdm660/afe_libs_cfg.json

~~~
VIM modify
~~~script
OSPL: Add lib, config ADSP for OSPL

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Date:      Wed May 31 16:56:53 2017 +0800
#
# interactive rebase in progress; onto 5baf27b
# Last commands done (2 commands done):
#    pick 7b8f9b5 OSPL: Add lib, config ADSP for OSPL
#    squash 47df5d8 OSPL: Move ospl to new place and Correct I2S port       Remove SPACE at the end of lines
# No commands remaining.
# You are currently editing a commit while rebasing branch 'cirrus' on '5baf27b'.
#
# Changes to be committed:
#       new file:   ADSP.VT.4.0/adsp_proc/avs/afe/algos/opalum/build/avs_libs/qdsp6/660.adsp.prod/capi_v2_opalum_strip.lib
#       new file:   ADSP.VT.4.0/adsp_proc/avs/afe/algos/opalum/build/opalum.scons
#       new file:   ADSP.VT.4.0/adsp_proc/avs/afe/algos/opalum/capi_v2_opalum/build/capi_v2_opalum.scons
#       new file:   ADSP.VT.4.0/adsp_proc/avs/afe/algos/opalum/capi_v2_opalum/inc/capi_v2_opalum_ext.h
#       modified:   ADSP.VT.4.0/adsp_proc/avs/afe/services/static/src/AFEPortAprHandler.cpp
#       modified:   ADSP.VT.4.0/adsp_proc/avs/api/afe/inc/adsp_afe_service_commands.h
#       modified:   ADSP.VT.4.0/adsp_proc/avs/build/sdm660/afe_libs_cfg.json
#
# Untracked files:
#       0001-OSPL-Add-lib-config-ADSP-for-OSPL.patch
#
~~~
~~~script
commit 34dfb57ce6816f313518bd1916f7123b9ae567df
Author: 钟庆龙 <loonzhong@meizu.com>
Date:   Wed May 31 16:56:53 2017 +0800

    OSPL: Add lib, config ADSP for OSPL

commit 5baf27b6a1312e041fc44e7d5e48abb30c019889
Author: konglingwei <konglingwei@meizu.com>
Date:   Mon May 29 21:17:09 2017 +0800

    [SCM]chipcode构建脚本
    
    Change-Id: I8fb37a443d1ea19a8aa181d5db04e8fac4fee116
~~~
