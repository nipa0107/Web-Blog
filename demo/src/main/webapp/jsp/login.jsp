<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        h2 {
            color: #333;
            text-align: center;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        div.error {
            color: red;
            margin-bottom: 15px;
            text-align: center;
        }

        form.register-form {
            margin-top: 20px;
            text-align: center;
        }

        form.register-form input[type="submit"] {
            background-color: #2196F3;
        }

        form.register-form input[type="submit"]:hover {
            background-color: #0b7dda;
        }
    </style>
</head>
<body>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <h2>เข้าสู่ระบบ</h2>

        <!-- แสดงข้อความผิดพลาด (ถ้ามี) -->
        <c:if test="${not empty error}">
            <div class="error">
                ${error}
            </div>
        </c:if>

        <label for="username">ชื่อผู้ใช้:</label>
        <input type="text" id="username" name="username" required>
        <br>
        <label for="password">รหัสผ่าน:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <input type="submit" value="เข้าสู่ระบบ">
        <div class="register-link">
            <p>ยังไม่มีบัญชีใช่หรือไม่? <a href="/register">ลงทะเบียน</a></p>
        </div>
    </form>
</body>
</html>
