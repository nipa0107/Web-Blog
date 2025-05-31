<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>เพิ่มโพสต์</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            color: #333;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            margin: 20px auto;
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 8px;
            color: #333;
        }

        select, input[type="text"] {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
        
        .error-message {
            color: red;
            font-size:14px;
            margin-top: 1px;
        }
           a {
            text-decoration: none;
            color: #333;
        }
    </style>
</head>
<body>

<h1>เพิ่มโพสต์ของคุณ</h1>

<form action="/addpost?sourcePage=dashboard" method="post" accept-charset="UTF-8">

    <label for="category">หัวข้อ:</label><br>
    <select id="category" name="category">
        <option value="" disabled selected>กรุณาเลือกหัวข้อ</option> 
        <option value="บ่น">บ่น</option>
        <option value="นอย">นอย</option>
        <option value="การเรียน">การเรียน</option>
        <option value="การทำงาน">การทำงาน</option>
        <option value="ครอบครัว">ครอบครัว</option>
    </select>
	<span class="error-message" id="category-error"></span><br>
    <label for="detail">รายละเอียด:</label><br>
    <input type="text" id="detail" name="detail"><br>
    <input type="submit" value="เพิ่ม">
</form>
    <c:if test="${not empty error}">
        <div style="color: red;">
            ${error}
        </div>
    </c:if>

    <a href="/dashboard">กลับหน้าหลัก</a>

<script>
    document.querySelector('form').addEventListener('submit', function(event) {
        var category = document.getElementById('category');
        var categoryError = document.getElementById('category-error');
        if (category.value === '') {
            categoryError.textContent = 'กรุณาเลือกหัวข้อ';
            event.preventDefault();
        } else {
            categoryError.textContent = '';
        }
    });
</script>
</body>
</html>
