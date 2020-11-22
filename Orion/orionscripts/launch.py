# Orion launch module
import lldb


def __lldb_init_module(debugger: lldb.SBDebugger, _) -> None:
    print("✨ \033[92mOrion loaded\033[0m")
    print('🔥 \033[35mPress command "orion" to start data session\033[0m')
    debugger.HandleCommand("command script add -f launch.start orion")


def start(debugger: lldb.SBDebugger, *args):
    print("XX")
