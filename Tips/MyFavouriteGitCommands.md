# My favourite Git Commands
## Use these!

How did you know active etc. In the end for the repo task??

When do we merge or rebase?
https://blog.jetbrains.com/idea/2017/07/git-questions-how-and-when-do-i-merge-or-rebase/?gclid=Cj0KCQiAlZH_BRCgARIsAAZHSBnaMhQSIXVJZe4PypEJ1mg_AmoFGBjQdgRWfnBcejori-d3nTZVcTcaAnQfEALw_wcB


If you create files without adding them, they move around when you switch branches. Then if you delete those files from one branch, they will be deleted in the other (because they are actually deleted).

Revert Changes not staged for commit
I always used git checkout -- . to clear my working directory (it restores working tree files). This reverses changes made to files that are tracked. This removes files not staged for commit. If you want to restore a particular file you can git checkout — FILENAME.md (it doesn’t have to be a markdown file), and this reverses the changes you have made up to the last commit.

Remove untracked files (clean the working tree)
 check with git clean -n
to actually do this we use git clean -fd

Push to a new branch on the remote
git push origin feature/simplebutton
better to let git suggest with git push
this will suggest
git push --set-upstream origin feature/simplebutton


Git restore  (remove files from the Index / staging area)
if you want to undo changes you made (since the last commit, that is changes that are not yet committed) you can use git restore. This means that we can restore some individual files (like mistaking too may files using git add using git restore —staged, git restore changes in the working directory (for the specified file). That means we move files from changes to be committed to untracked files, but it still stays  in the file system (and is now an untacked file in git, but it knows it is there).

get rid of changes to be committed
You have changes that you shouldn’t have (perhaps by switching branch). restore them, and then remove untracked files with clean.

alternative undo git add
git reset <file> or git reset upstages changes

undo a commit (remove the last commit from the current branch). Move back one commit.
This remove the latest commit from the current branch, but the changes stay in the working tree so move back one commit, don’t lose any work
git reset —-soft head~1
If you want to LOSE all uncommitted changes - so there will no git command that gets them back. Move back one commit, lose all work
git reset —-hard head~1
if you want to only reset files that are different between the current head and abord if any file has uncommitted changes use
git reset —-keep HEAD~1

If reset goes wrong you can find the SHA-1 key using git reflog, and say a git checkout SHA-1 (replacing SHA-1 with the reference)

Branch ahead of development
Revealed by a git status, could be ahead by 1, 2 or 3 commits and git pull will not work
could delete the branch (or rename), git checkout -b development and then git pull - in this case I needed to set upstream with git branch --set-upstream-to=origin/development development but this was recommended by git.
Instead I could try git pull --rebase (the default is merge)that “First, rewinding head to replay your work on top of it…” so this will KEEP the local changes.
git reset —hard origin/development works!

Stop merge 
we can do this with git merge —abort

Update from the remote
 git fetch --all
 git reset --hard origin/development
This discards all local changes
because git fetch downloads the latest from the remote without trying to merge or rebase anything.
This will REMOVE (as HARD) both changes as well as files from the working directory.
If you want to keep the changes for a potential commit, you can use git reset --soft origin/development which then keeps the changes in order to be able to commit them later (in terms of development branch, we can then switch branch with git checkout -b newchanges and then commit and use accordingly

Git pull
After a git fetch a git pull does not try to rebase anything.
Git pull performed after a git fetch is the same as a git merge origin/<branch> and so attempts to preserve local changes. An alternative is git pull —rebase (the default is merge) that replays your changes on top of the remote work. If there is a problem with rebase (https://stackoverflow.com/questions/29902967/rebase-in-progress-cannot-commit-how-to-proceed-or-stop-abort) tells us not to be scared of git rebase —skip

Rebase
NEVER rebase on public branches
now rebating re-write the project history and does not have the commits for merging. This is mostly for merging back into dev, but rebasing provides a better linear history (less mixed up) but merging has a better traceability. In other words, it shouldn’t matter too much.

git commit —amend this replaces the last  https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet
git commit --amend -m "New commit message"

Interesting fix git amend 

Cherry-pick
git cherry-pick SHA

Resolve conflict
git mergetool will open up the default mergetool. In order to open opendiff you can use the one off command
git mergetool -t opendiff
Using opendiff the arrow points to the line that you want. You can also change the section at the bottom to create a merged part.
Save the merge, then close mergetool to be asked if the merge is successful.