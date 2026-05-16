<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found | OccasioDesign</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <style>
        body {
            font-family: 'Jost', sans-serif;
            background: #f5f0ff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .error-box {
            text-align: center;
            background: white;
            padding: 60px 40px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            max-width: 420px;
        }
        .error-box h1 {
            font-size: 6rem;
            color: var(--emerald);
            margin: 0 0 10px 0;
            font-weight: 700;
        }
        .error-box h2 {
            color: #333;
            margin-bottom: 15px;
        }
        .error-box p {
            color: #666;
            font-size: 1.05rem;
        }
        .btn-home {
            display: inline-block;
            margin-top: 25px;
            padding: 14px 32px;
            background: var(--emerald);
            color: white;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.05rem;
        }
        .btn-home:hover {
            background: var(--emerald-dark);
        }
    </style>
</head>
<body>
    <div class="error-box">
        <h1>404</h1>
        <h2>Page Not Found</h2>
        <p>The page you are looking for does not exist or has been moved.</p>
        <a href="${pageContext.request.contextPath}/home" class="btn-home">
            ← Go Back to Home
        </a>
    </div>
</body>
</html>