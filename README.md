# Labs and Homework GitHub Repository for EELE468


## Directory Structure

- 📁 **docs**: documentation and lab reports
- 📁 **quartus**: quartus project folder
- 📁 **adc-controller**: custom ADC controller component


## Branch and Tag Naming Conventions

- **Branch names:** lab-\<#\>, e.g. `lab-7`
- **Tag names:** lab-\<#\>-submission, e.g. `lab-7-submission`


## Git Workflow for Labs and Homework

The work for each assignment takes place on a dedicated feature branch for that assignment.
Upon completion, the feature branch will be merged into `main`, without fast-forwarding (i.e. forcing a merge commit to be created).
This preserves the branch structure, so that proper development flow can be verified by inspecting the resulting history.

Further, each commit should be (relatively) atomic.
That is, each commit does one, and only one simple thing, which can be summed up in a simple sentence — the amount of code change doesn't matter.
Writing atomic commits forces us to make small, manageable changes as we tackle large tasks.
