import { editor } from "monaco-editor";

import "./index.scss";

const container = document.getElementById("monaco-root");

if (container) {
  editor.create(container, {
    automaticLayout: true,
  });
}
