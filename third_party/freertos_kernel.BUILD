cc_library(
    name = "freertos_facade",
    hdrs = [
        "include/FreeRTOS.h",
        "include/StackMacros.h",
        "include/atomic.h",
        "include/croutine.h",
        "include/deprecated_definitions.h",
        "include/event_groups.h",
        "include/list.h",
        "include/message_buffer.h",
        "include/mpu_prototypes.h",
        "include/mpu_wrappers.h",
        "include/portable.h",
        "include/projdefs.h",
        "include/queue.h",
        "include/semphr.h",
        "include/stack_macros.h",
        "include/stream_buffer.h",
        "include/task.h",
        "include/timers.h",
    ],
    includes = ["include"],
)

cc_library(
    name = "freertos",
    srcs = [
        "croutine.c",
        "event_groups.c",
        "list.c",
        "queue.c",
        "stream_buffer.c",
        "tasks.c",
        "timers.c",
    ],
    linkstatic = True,
    visibility = ["//visibility:public"],
    deps = [
        ":config",
        ":freertos_facade",
        ":port",
    ],
)

label_flag(
    name = "config",
    build_setting_default = "@rules_freertos//:default_config",
)

cc_library(
    name = "third_party_posix_port",
    srcs = [
        "portable/ThirdParty/GCC/Posix/port.c",
        "portable/ThirdParty/GCC/Posix/utils/wait_for_event.c",
    ],
    hdrs = [
        "portable/ThirdParty/GCC/Posix/portmacro.h",
        "portable/ThirdParty/GCC/Posix/utils/wait_for_event.h",
    ],
    includes = ["portable/ThirdParty/GCC/Posix"],
    target_compatible_with = select({
        "@platforms//os:linux": [],
        "@platforms//os:macos": [],
        "@platforms//os:freebsd": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    deps = [
        ":config",
        ":freertos_facade",
    ],
)

cc_library(
    name = "gcc_arm_cm4f_port",
    srcs = [
        "portable/GCC/ARM_CM4F/port.c",
    ],
    hdrs = [
        "portable/GCC/ARM_CM4F/portmacro.h",
    ],
    includes = ["portable/GCC/ARM_CM4F"],
    target_compatible_with = [
        "@platforms//cpu:armv7e-m",
    ],
    deps = [
        ":config",
        ":freertos_facade",
    ],
)

# TODO(bazelbuild/#14310): Bazel doesn't allow us to specify selects with
# constraint_values with aliase's, however it allows it on
# config_settings. Remove this workaround when #14310 is incorporated
# into next release.
[
    config_setting(
        name = os,
        constraint_values = ["@platforms//os:" + os],
    )
    for os in [
        "linux",
        "macos",
        "freebsd",
    ]
]

config_setting(
    name = "cm4",
    constraint_values = ["@platforms//cpu:armv7e-m"],
)

alias(
    name = "default_port",
    actual = select({
        # TODO(bazelbuild/#14310): Bazel doesn't allow us to specify selects with
        # constraint_values with aliase's, however it allows it on
        # config_settings. Remove this workaround when #14310 is incorporated
        # into next release.
        ":cm4": ":gcc_arm_cm4f_port",
        ":linux": ":third_party_posix_port",
        ":macos": ":third_party_posix_port",
        ":freebsd": ":third_party_posix_port",
    }),
)

label_flag(
    name = "port",
    build_setting_default = ":default_port",
)
