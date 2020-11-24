# Orion launch module

import lldb
import json
import threading
import http.server
from urllib.parse import urlparse
import gzip

# LLDB language map
# =======================================================
# ██╗     ██╗     ██████╗ ██████╗     ██╗      █████╗ ███╗   ██╗ ██████╗ ██╗   ██╗ █████╗  ██████╗ ███████╗    ███╗   ███╗ █████╗ ██████╗
# ██║     ██║     ██╔══██╗██╔══██╗    ██║     ██╔══██╗████╗  ██║██╔════╝ ██║   ██║██╔══██╗██╔════╝ ██╔════╝    ████╗ ████║██╔══██╗██╔══██╗
# ██║     ██║     ██║  ██║██████╔╝    ██║     ███████║██╔██╗ ██║██║  ███╗██║   ██║███████║██║  ███╗█████╗      ██╔████╔██║███████║██████╔╝
# ██║     ██║     ██║  ██║██╔══██╗    ██║     ██╔══██║██║╚██╗██║██║   ██║██║   ██║██╔══██║██║   ██║██╔══╝      ██║╚██╔╝██║██╔══██║██╔═══╝
# ███████╗███████╗██████╔╝██████╔╝    ███████╗██║  ██║██║ ╚████║╚██████╔╝╚██████╔╝██║  ██║╚██████╔╝███████╗    ██║ ╚═╝ ██║██║  ██║██║
# ╚══════╝╚══════╝╚═════╝ ╚═════╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝
# =======================================================
LANG_MAP = dict(
    [
        (lldb.eLanguageTypeAda83, "Ada"),
        (lldb.eLanguageTypeAda95, "Ada"),
        (lldb.eLanguageTypeC, "C"),
        (lldb.eLanguageTypeC11, "C"),
        (lldb.eLanguageTypeC89, "C"),
        (lldb.eLanguageTypeC99, "C"),
        (lldb.eLanguageTypeC_plus_plus, "C_plus_plus"),
        (lldb.eLanguageTypeC_plus_plus_03, "C_plus_plus"),
        (lldb.eLanguageTypeC_plus_plus_11, "C_plus_plus"),
        (lldb.eLanguageTypeC_plus_plus_14, "C_plus_plus"),
        (lldb.eLanguageTypeCobol74, "Cobol"),
        (lldb.eLanguageTypeCobol85, "Cobol"),
        (lldb.eLanguageTypeD, "D"),
        (lldb.eLanguageTypeFortran03, "Fortran"),
        (lldb.eLanguageTypeFortran08, "Fortran"),
        (lldb.eLanguageTypeFortran77, "Fortran"),
        (lldb.eLanguageTypeFortran90, "Fortran"),
        (lldb.eLanguageTypeFortran95, "Fortran"),
        (lldb.eLanguageTypeGo, "Go"),
        (lldb.eLanguageTypeHaskell, "Haskell"),
        (lldb.eLanguageTypeJava, "Java"),
        (lldb.eLanguageTypeJulia, "Julia"),
        (lldb.eLanguageTypeMipsAssembler, "MipsAssembler"),
        (lldb.eLanguageTypeObjC, "ObjC"),
        (lldb.eLanguageTypeObjC_plus_plus, "C_plus_plus"),
        (lldb.eLanguageTypeOCaml, "OCaml"),
        (lldb.eLanguageTypeOpenCL, "OpenCL"),
        (lldb.eLanguageTypePascal83, "Pascal"),
        (lldb.eLanguageTypePython, "Python"),
        (lldb.eLanguageTypePLI, "PLI"),
        (lldb.eLanguageTypeRust, "Rust"),
        (lldb.eLanguageTypeSwift, "Swift"),
        (lldb.eLanguageTypeUnknown, "Unknown"),
    ]
)

# Server
# =======================================================
# ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗
# ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗
# ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝
# ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗
# ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝
# =======================================================

# lldb hook
def __lldb_init_module(debugger: lldb.SBDebugger, _) -> None:
    print("✨ \033[92mOrion loaded\033[0m")
    print('🔥 \033[35mPress command "orion" to start data session\033[0m')
    debugger.HandleCommand("command script add -f launch.start orion")


# start child thread for web server
def start(debugger: lldb.SBDebugger, *args):
    tr = server_thread(debugger)
    tr.start()


class server_thread(threading.Thread):
    def __init__(self, debugger: lldb.SBDebugger) -> None:
        threading.Thread.__init__(self)
        self.debugger = debugger

    def run(self) -> None:
        httpd = http.server.ThreadingHTTPServer(
            ("localhost", 9000), handle_request(self.debugger)
        )
        httpd.serve_forever()


# handle all request
def handle_request(debugger: lldb.SBDebugger):
    debuggerID = debugger.GetID()

    class request_handler(http.server.SimpleHTTPRequestHandler):
        handler_map = {"/ping": handle_ping, "/summary": handle_summary}

        def log_message(self, format: str, *args) -> None:
            pass

        def do_GET(self) -> None:
            url = urlparse(self.path)
            return_bin = url.query == "bin"

            handle_func = self.handler_map.get(url.path)

            res_class = (
                handle_func(lldb.SBDebugger.FindDebuggerWithID(debuggerID))
                if handle_func
                else {}
            )

            res_string = json.dumps(res_class, default=serialize).encode(
                encoding="utf-8"
            )

            self.send_response(200)
            if return_bin:
                self.send_header("Content-type", "application/octet-stream")
                self.end_headers()
                self.wfile.write(gzip.compress(res_string))
            else:
                self.send_header("Content-type", "application/json; charset=UTF-8")
                self.end_headers()
                self.wfile.write(res_string)
            return

    return request_handler


def handle_ping(debugger: lldb.SBDebugger):
    return {"pong": "pong"}


def handle_summary(debugger: lldb.SBDebugger):
    return LLDBConnector(debugger)


# serialize function for class to json
def serialize(obj):
    return dict(
        (prop, getattr(obj, prop))
        for prop in [
            k
            for k in obj.__class__.__dict__
            if isinstance(obj.__class__.__dict__[k], property)
        ]
    )


# LLDB data converter
# =======================================================
# ██╗     ██╗     ██████╗ ██████╗     ██████╗  █████╗ ████████╗ █████╗      ██████╗ ██████╗ ███╗   ██╗██╗   ██╗███████╗██████╗ ████████╗███████╗██████╗
# ██║     ██║     ██╔══██╗██╔══██╗    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗    ██╔════╝██╔═══██╗████╗  ██║██║   ██║██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔══██╗
# ██║     ██║     ██║  ██║██████╔╝    ██║  ██║███████║   ██║   ███████║    ██║     ██║   ██║██╔██╗ ██║██║   ██║█████╗  ██████╔╝   ██║   █████╗  ██████╔╝
# ██║     ██║     ██║  ██║██╔══██╗    ██║  ██║██╔══██║   ██║   ██╔══██║    ██║     ██║   ██║██║╚██╗██║╚██╗ ██╔╝██╔══╝  ██╔══██╗   ██║   ██╔══╝  ██╔══██╗
# ███████╗███████╗██████╔╝██████╔╝    ██████╔╝██║  ██║   ██║   ██║  ██║    ╚██████╗╚██████╔╝██║ ╚████║ ╚████╔╝ ███████╗██║  ██║   ██║   ███████╗██║  ██║
# ╚══════╝╚══════╝╚═════╝ ╚═════╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
# =======================================================


class LLDBConnector:
    def __init__(self, debugger: lldb.SBDebugger) -> None:
        self.debugger = debugger

    @property
    def targets(self):
        return [
            LLDBTarget(self.debugger.GetTargetAtIndex(i), i)
            for i in range(self.debugger.GetNumTargets())
        ]


class LLDBTarget:
    def __init__(self, target: lldb.SBTarget, index: int) -> None:
        self.target = target
        self.index = index

    @property
    def executableName(self):
        return str(self.target.GetExecutable())

    @property
    def targetIndex(self):
        return int(self.index)

    @property
    def targetPlatform(self):
        return str(self.target.GetTriple())

    @property
    def modules(self):
        return [LLDBModule(m) for m in self.target.modules]


class LLDBModule:
    def __init__(self, module: lldb.SBModule) -> None:
        self.module = module

    @property
    def moduleName(self):
        return str(self.module.file)

    @property
    def compileUnits(self):
        return [
            LLDBCompileUnit(self.module.GetCompileUnitAtIndex(i))
            for i in range(self.module.GetNumCompileUnits())
        ]


class LLDBCompileUnit:
    def __init__(self, unit: lldb.SBCompileUnit) -> None:
        self.unit = unit

    @property
    def filePath(self):
        return str(self.unit.file)

    @property
    def language(self):
        return LANG_MAP.get(self.unit.GetLanguage(), "Unknown")
