# Contributing

## Bug reports and feature requests

Submit these to https://github.com/GHTaarn/UnicodeREPL.jl/issues

## Pull requests

I have limited time to develop this application, so good code contributions are welcome.
For pull requests, please have the following in mind:

 - Use Julia naming conventions
 - Indent with 4 spaces
 - Use good programming practices
 - Document exported symbols with docstrings
 - Try to use the existing style, even if it is not entirely your taste
 - If you make something that looks stupid at first glance, please explain it with a comment so that people are not tempted to tidy it in an incorrect way (if you make something that looks stupid and is stupid, please tidy it before submitting the pull request (unless it is meant as a mockup))
 - New functions/methods should get a new testcase (functions/methods that are extremely simple are exempted)

## For developers with write permission to the UnicodeREPL.jl Github repository:

 - Branches are named as in the Julia git repository:
      - master : New feature development. All tests should pass. Version should be x.x.0-DEV
      - release-x.x : A stable release for each minor version, all tests should pass. Unlike the Julia repository, do not commit anything here unless it is verified release ready and has version x.x.x
 - Release procedure for x.x.0 releases:
   0. Inform everyone with write permission that you are starting the release procedure
   1. Run unit tests
   2. Read through README.md and try out all code examples to verify that they work
   3. Instruct everyone with write permission to hold off commits to master until you give the green light & check that your master is up to date
   4. Edit Project.toml changing version to x.x.0
   5. Create the branch release-x.x
   6. On the master branch, edit Project.toml and bump up its version to x.x.0-DEV (where the minor version is increased by one, or major version is increased by one and minor version is set to zero)
   7. Push master and the new branch to Github
   8. Inform everyone with write permission that it is safe to commit to master
   8. Write a comment containing the text `@JuliaRegistrator register branch=release-x.x` on the commit on Github to trigger the Julia registrator to register the new version. (You can write release notes in the second and subsequent lines of the comment)
   9. On Github, create a new release, giving release-x.x the tag vx.x.0
   10. Optionally update the `nocompat` branch

 - Release procedure for patch releases (x.x.x releases):
   0. Inform everyone with write permission that you are starting the patch release procedure
   1. Create a new temporary branch (e.g. dev-x.x.x) from release-x.x
   2. Commits to the temporary branch should preferably be created using `git cherry-pick -x master~ZZZ` (or refer to the commit on the **master** branch in another way)
   3. Increase the version in *Project.toml* to x.x.x and commit
   4. If you committed blunders to the temporary branch, just delete it and create a new one
   5. Test the temporary branch
   6. Merge the temporary branch into release-x.x (e.g. `git switch release-x.x; git merge dev-x.x.x`)
   7. Push to Github
   8. Write a comment containing the text `@JuliaRegistrator register branch=release-x.x` on the commit on Github to trigger the Julia registrator to register the new version. (You can write release notes in the second and subsequent lines of the comment)
   9. On Github, create a new release, giving release-x.x the tag vx.x.x
   10. Optionally update the `nocompat` branch. Often this can be done by creating a new branch off `nocompat`, cherry picking from the release-x.x branch (using the -x flag), testing and finally merging this into the `nocompat` branch and pushing to Github.
