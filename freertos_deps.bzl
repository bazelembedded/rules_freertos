load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

def freertos_deps():
    if "com_github_freertos_freertos_kernel" not in native.existing_rules():
        new_git_repository(
            name = "com_github_freertos_freertos_kernel",
            remote = "https://github.com/FreeRTOS/FreeRTOS-Kernel.git",
            commit = "a4b28e35103d699edf074dfff4835921b481b301",
            build_file = "@rules_freertos//third_party:freertos_kernel.BUILD",
            shallow_since = "1636743931 -0800",
        )
