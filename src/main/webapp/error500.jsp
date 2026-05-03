<%@ page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>500 - Server Error</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding: 80px 20px; background: #fff5f5; }
        h1 { font-size: 4rem; color: #dc2626; margin: 0; }
        h2 { color: #333; }
        a { display: inline-block; margin-top: 20px; padding: 10px 24px; background: #7c3aed; color: white; border-radius: 8px; text-decoration: none; }
    </style>
</head>
<body>
    <h1>500</h1>
    <h2>Something went wrong</h2>
    <p>Please try again later.</p>
    <a href="${pageContext.request.contextPath}/home">Go Back Home</a>
</body>
</html>