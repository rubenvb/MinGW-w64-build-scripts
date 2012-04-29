#! /bin/bash
# git clone git://gcc.gnu.org/git/gcc.git && cd gcc
s=svn://gcc.gnu.org/svn/gcc
# git svn init $s

echo 'Creating tags.db (This takes several seconds.)'
git log --grep=git-svn-id: --remotes \
| egrep '(^commit |git-svn-id: )' \
| sed -e 's/^ *git-svn-id:[^@]*@\([0-9]*\).*/\1/' \
| awk 'BEGIN { RS = "commit " ; FS = "\n" } { print $1, $2 }' \
> tags.db

echo 'Reading tags.db'
while read cid rev ; do commit[$rev]=$cid ; done < tags.db

echo 'Fetching SVN revisions and tagging'
echo '                                          SVN rev'
echo ' Git commit ID                            in git  SVN rev Tag'
echo ' ======================================== ======= ======= ======= = = ='
echo ' (Waiting for remote svn info.  This takes a few seconds.)'
for t in `svn ls $s/tags | fgrep release | sed -e 's@/$@@'`
do
  rev=`svn info $s/tags/$t | grep '^Last Changed Rev: ' | awk '{ print $4 }'`
  # Scan the svn log for the first SVN revision mirrored in GIT.
  # This is required because git-svn does not mirror SVN tag/branch revisions.
  for r in `svn log -l 2 $s/tags/$t \
            | grep '^r[0-9][0-9]* | ' \
            | awk '{ print $1 }' \
            | sed -e 's/r//'`
  do 
    if [ x"${commit[$r]}" = x ] ; then continue ; fi
    printf " %40s %7s %7s %s\n" "${commit[$r]}" "$r" "$rev" "$t"
    if [ x"${commit[$r]}" != x ] ; then 
        git tag -f "$t" "${commit[$r]}"
    fi
    break
  done
done

echo 'Removing tags.db'
rm tags.db
echo 'Done.'
