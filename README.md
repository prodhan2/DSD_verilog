<!DOCTYPE html>
<html>
<head>
  <title>Code Copy System</title>
</head>
<body>
  <div class="code-block">
    <pre><code>
      // This is some code.
      console.log("Hello, world!");
    </code></pre>
    <button class="copy-button">Copy Code</button>
  </div>

  <script>
    function copyCode() {
      var codeBlock = document.querySelector(".code-block");
      var code = codeBlock.querySelector("pre").textContent;
      var clipboard = new ClipboardJS();
      clipboard.writeText(code);
    }

    document.querySelector(".copy-button").addEventListener("click", copyCode);
  </script>
</body>
</html>
