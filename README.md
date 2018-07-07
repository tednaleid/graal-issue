# graal-issue
demonstrates issue with graal native-image compilation when using subdirectories

issue: https://github.com/oracle/graal/issues/530

run:

    ./show-issue.sh
    
to see it blow up with a confusing error message

# detail from issue

If I run the following command to try to compile a jar in a subdirectory that has the same name as the jar's base name:

    native-image -jar graal-issue-core/build/libs/graal-issue-core.jar

it fails with a confusing error message that says

    fatal error: java.lang.RuntimeException: java.lang.RuntimeException: host C compiler or linker does not seem to work: java.lang.RuntimeException: returned 1

Buried in a bunch of other stack traces, it eventually says:

    ld: can't open output file for writing: /private/tmp/graal-issue/graal-issue-core, errno=21 for architecture x86_64

Which took me far longer to realize than it should have that it was because it was trying to generate a file with the same path as an existing subdirectory in my current directory.

As far as I can tell, there isn't an option in `native-image` to output the file to a different name.  I think there should be clearer upfront detection that the path it is trying to write the binary to isn't valid.   

my environment:
```
java -version
java version "1.8.0_172"
Java(TM) SE Runtime Environment (build 1.8.0_172-b11)
GraalVM 1.0.0-rc3 (build 25.71-b01-internal-jvmci-0.45, mixed mode)
```

```
sw_vers
ProductName:    Mac OS X
ProductVersion:    10.13.5
BuildVersion:    17F77
```

