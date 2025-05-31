<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        h2 {
            color: #333;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            margin: 50px auto;
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
        }

        form.login-form {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form action="/register" method="post">
    <h2>ลงทะเบียน</h2>

    <!-- แสดงข้อความผิดพลาด (ถ้ามี) -->
    <c:if test="${not empty error}">
        <div class="error">
            ${error}
        </div>
    </c:if>

    <label for="firstname">ชื่อ:</label>
<input type="text" id="firstname" name="firstname" required>

<label for="lastname">นามสกุล:</label>
<input type="text" id="lastname" name="lastname" required>


    <label for="username">ชื่อผู้ใช้:</label>
    <input type="text" id="username" name="username" required>

    <label for="password">รหัสผ่าน:</label>
    <input type="password" id="password" name="password" required>

    <input type="submit" value="ลงทะเบียน">
    
    <div class="register-link">
        <p>มีบัญชีแล้วใช่หรือไม่? <a href="/login">เข้าสู่ระบบ</a></p>
    </div>
</form>

</body>
</html>
