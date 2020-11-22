# Orion launch module

import lldb
import json
import threading
import http.server


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
        handler_map = {"/ping": handle_ping, "/report": handle_report}

        def log_message(self, format: str, *args) -> None:
            pass

        def do_GET(self) -> None:
            handle_func = self.handler_map.get(self.path)
            res_data = (
                handle_func(lldb.SBDebugger.FindDebuggerWithID(debuggerID))
                if handle_func
                else {}
            )
            self.send_response(200)
            self.end_headers()
            self.wfile.write(
                json.dumps(res_data, default=serialize).encode(encoding="utf-8")
            )
            return

    return request_handler


def handle_ping(debugger: lldb.SBDebugger):
    return {"pong": "pong"}


def handle_report(debugger: lldb.SBDebugger):
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
    def executable_name(self):
        return str(self.target.GetExecutable())

    @property
    def target_index(self):
        return self.index

    @property
    def modules(self):
        return [LLDBModule(m) for m in self.target.modules]


class LLDBModule:
    def __init__(self, module: lldb.SBModule) -> None:
        self.module = module

    @property
    def module_name(self):
        return str(self.module.file)
