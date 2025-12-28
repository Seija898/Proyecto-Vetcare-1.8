<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>VetCare | Login</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            height: 100vh;
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-card {
            background: #ffffff;
            width: 360px;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .login-card h2 {
            color: #333;
            margin-bottom: 5px;
        }

        .subtitle {
            font-size: 14px;
            color: #777;
            margin-bottom: 25px;
        }

        .input-group {
            text-align: left;
            margin-bottom: 18px;
        }

        .input-group label {
            font-size: 14px;
            color: #555;
            display: block;
            margin-bottom: 5px;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
            outline: none;
        }

        .input-group input:focus {
            border-color: #4facfe;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #4facfe;
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .error-msg {
            margin-top: 15px;
            background: #ffe0e0;
            color: #b00000;
            padding: 10px;
            border-radius: 8px;
            font-size: 14px;
        }
    </style>
</head>

<body>

<div class="login-card">
    <h2>VetCare</h2>
    <p class="subtitle">Sistema de Gestión Veterinaria</p>

    <form action="<%=request.getContextPath()%>/login" method="post">
        <div class="input-group">
            <label>Usuario</label>
            <input type="text" name="usuario" required>
        </div>

        <div class="input-group">
            <label>Contraseña</label>
            <input type="password" name="password" required>
        </div>

        <button type="submit">Iniciar Sesión</button>
    </form>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="error-msg"><%= error %></div>
    <%
        }
    %>
</div>

</body>
</html>


