\<!DOCTYPE html>
<html>
<head>
    <style>
        .code-container {
            position: relative;
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 20px;
            background-color: #f5f5f5;
        }
        .copy-button {
            position: absolute;
            top: 5px;
            right: 5px;
            padding: 5px 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }
    </style>
    <script>
        function copyCode(containerId) {
            var codeContainer = document.getElementById(containerId);
            var codeText = codeContainer.textContent;
            var tempTextarea = document.createElement('textarea');
            tempTextarea.value = codeText;
            document.body.appendChild(tempTextarea);
            tempTextarea.select();
            document.execCommand('copy');
            document.body.removeChild(tempTextarea);
        }
    </script>
</head>
<body>
    <div class="code-container" id="code-block-1">
        <pre><code>
module adder_subtractor(s, cout, a, b, mode);
    input [3:0] a, b;
    input mode;
    output [3:0] s;
    output cout;
    wire c0, c1, c2;
    // ... (your Verilog code)
        </code></pre>
        <button class="copy-button" onclick="copyCode('code-block-1')">Copy</button>
    </div>
    <!-- Add more code containers with different IDs and content -->

</body>
</html>
