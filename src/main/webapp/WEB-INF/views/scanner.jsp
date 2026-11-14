
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Scanner | NutriFlux</title>

    <script src="https://unpkg.com/html5-qrcode"></script>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f7f6;
            margin: 0;
            padding: 30px;
        }

        .scanner-container {
            max-width: 550px;
            margin: 40px auto;
            padding: 25px;
            background: white;
            border-radius: 14px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        #reader {
            width: 100%;
            margin: 20px auto;
        }

        #scanResult {
            margin-top: 20px;
            padding: 12px;
            background: #f1f5f9;
            border-radius: 8px;
            overflow-wrap: anywhere;
            line-height: 1.5;
        }

        button {
            padding: 12px 22px;
            border: none;
            border-radius: 8px;
            background: #16a085;
            color: white;
            cursor: pointer;
            margin: 8px;
        }

        button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .error {
            color: #dc2626;
        }

        .success {
            color: #15803d;
        }
    </style>
</head>

<body>

<div class="scanner-container">

    <h2>NutriFlux Inventory Scanner</h2>

    <p>Scan a product QR code to increase its inventory quantity.</p>

    <!-- Spring Security CSRF details -->
    <input type="hidden"
           id="csrfToken"
           value="${_csrf.token}">

    <input type="hidden"
           id="csrfHeader"
           value="${_csrf.headerName}">

    <div id="reader"></div>

    <div id="scanResult">
        Waiting for QR code...
    </div>

    <button id="startButton" onclick="startScanner()">
        Start Scanner
    </button>

    <button id="stopButton"
            onclick="stopScanner()"
            disabled>
        Stop Scanner
    </button>

</div>

<script>
    const contextPath = "<%= contextPath %>";

    let html5QrCode = null;
    let isScanning = false;
    let isProcessingScan = false;

    const resultElement = document.getElementById("scanResult");
    const startButton = document.getElementById("startButton");
    const stopButton = document.getElementById("stopButton");

    // START CAMERA
    async function startScanner() {

        if (isScanning) return;

        try {

            html5QrCode = new Html5Qrcode("reader");

            const cameras = await Html5Qrcode.getCameras();

            if (!cameras || cameras.length === 0) {
                throw new Error("No camera detected.");
            }

            // Select the first available camera.
            const cameraId = cameras[0].id;

            await html5QrCode.start(
                cameraId,
                {
                    fps: 10,
                    qrbox: {
                        width: 250,
                        height: 250
                    }
                },
                onScanSuccess,
                onScanFailure
            );

            isScanning = true;

            startButton.disabled = true;
            stopButton.disabled = false;

            resultElement.className = "";
            resultElement.textContent =
                "Camera started. Point it at a QR code.";

        } catch (error) {

            console.error("Camera error:", error);

            resultElement.className = "error";
            resultElement.textContent =
                "Unable to start camera: " + error.message;
        }
    }

    // QR SCAN SUCCESS
    async function onScanSuccess(decodedText) {

        if (isProcessingScan) return;

        isProcessingScan = true;

        const barcode = decodedText.trim();

        resultElement.className = "";
        resultElement.textContent =
            "Processing barcode: " + barcode;

        console.log("Decoded QR value:", barcode);

        try {

            const csrfToken =
                document.getElementById("csrfToken").value;

            const csrfHeader =
                document.getElementById("csrfHeader").value;

            const headers = {};

            if (csrfToken && csrfHeader) {
                headers[csrfHeader] = csrfToken;
            }

            // Construct API URL without JSP-conflicting template literals.
            const apiUrl =
                contextPath +
                "/api/inventory/scan/" +
                encodeURIComponent(barcode);

            const response = await fetch(apiUrl, {
                method: "POST",
                headers: headers,
                credentials: "same-origin"
            });

            const responseText = await response.text();

            let data;

            try {
                data = JSON.parse(responseText);
            } catch (error) {
                throw new Error(
                    "Server returned an unexpected response. Check authentication and API URL."
                );
            }

            if (!response.ok) {
                throw new Error(
                    data.message || "Inventory update failed. HTTP " + response.status
                );
            }

            // Display updated inventory information.
            resultElement.className = "success";

            resultElement.textContent =
                "Success! " +
                data.product +
                " | Updated quantity: " +
                data.quantity;

            console.log("Inventory updated:", data);

            // Stop camera after successful scan.
            await stopScanner(false);

        } catch (error) {

            console.error("API error:", error);

            resultElement.className = "error";
            resultElement.textContent =
                "Error: " + error.message;

        } finally {

            isProcessingScan = false;
        }
    }

    // NORMAL SCANNING FAILURE CALLBACK
    function onScanFailure(error) {
        // No QR detected in this frame. This is normal.
    }

    // STOP CAMERA
    async function stopScanner(showMessage = true) {

        if (!html5QrCode || !isScanning) return;

        try {

            await html5QrCode.stop();

            isScanning = false;

            startButton.disabled = false;
            stopButton.disabled = true;

            if (showMessage) {
                resultElement.className = "";
                resultElement.textContent = "Scanner stopped.";
            }

        } catch (error) {

            console.error("Stop scanner error:", error);

            resultElement.className = "error";
            resultElement.textContent =
                "Unable to stop scanner: " + error.message;
        }
    }
</script>

</body>
</html>
