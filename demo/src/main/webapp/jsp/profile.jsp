<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile</title>
        <style type="text/css">
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
            display: flex;
            margin-bottom: 20px;
        }

        label {
            margin-right: 10px;
        }

        select, input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 10px;
        }

        button {
            background-color: #4caf50;
            color: white;
            padding: 8px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        .box {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
            width: 70%;
            margin: 10px auto;
            background-color: #fff;
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px; /* เพิ่มขึ้นมาเพื่อให้มีระยะห่างระหว่าง header กับข้อความ */
        }

        a.edit-link, a.delete-link {
            text-decoration: none;
            color: #333;
        }

        .like-link {
            color: #333;
            text-decoration: none;
            cursor: pointer;
        }

        .like-link:hover {
            text-decoration: underline;
        }

        a.add-post-link {
            text-decoration: none;
            color: #fff;
            background-color: #4caf50;
            padding: 8px;
            border-radius: 4px;
            margin-top: 10px;
            display: inline-block;
        }

        p.no-posts {
            text-align: center;
            font-style: italic;
        }

        a.logout-link {
            background-color: red;
            padding: 8px;
            border-radius: 4px;
            margin-top: 10px;
            color: white;
            display: inline-block;
            text-decoration: none;
        }
         a {
            text-decoration: none;
            color: #333;
        }
    </style>
</head>
<body>
    <h2>Profile</h2>
   <p><b>ชื่อผู้ใช้:</b> ${loggedInUsername}  <b>ชื่อ:</b> ${sessionScope.loggedInFirstname} <b>นามสกุล:</b> ${sessionScope.loggedInLastname}</p>

   <a href="/dashboard">กลับหน้าหลัก</a>

<a class="add-post-link" href="${pageContext.request.contextPath}/addpostself?sourcePage=profile">เพิ่มโพสต์ของคุณ</a>

<c:if test="${not empty posts}">
    <c:forEach var="post" items="${posts}">
        <div class="box">
            <div>
       <c:if test="${post.author eq loggedInUsername}">
    <a class="edit-link" href="${pageContext.request.contextPath}/editpostself/${post.id}">Edit</a>
    <a class="delete-link" href="javascript:void(0);" onclick="confirmDelete(${post.id})">Delete</a>
</c:if>
                <h2>${post.author}</h2>
                <p>หมวดหมู่: ${post.category}</p>
                <p>${post.detail}</p>
               <!--<c:url var="likeUrl" value="${pageContext.request.contextPath}/like/${post.id}" />  --> 
                
                <p>จำนวนคนกดไลค์: ${post.love} คน</p>
            	 <p>วันที่โพสต์: ${post.timestamp}</p>
                <a class="like-link" id="likeButton-${post.id}" href="${likeUrl}" onclick="likePost(${post.id}, '${post.likedUsernames.contains(loggedInUsername)}')">Love</a>
            </div>
             <div class="comments">
    <h3>ความคิดเห็น:</h3>
    <c:forEach var="comment" items="${post.comments}">
        <p>${comment.author}: ${comment.content}</p>
    </c:forEach>
    
    <!-- Form for adding a comment -->
    <form action="${pageContext.request.contextPath}/addComment" method="post">
        <input type="hidden" name="postId" value="${post.id}" />
        <label for="comment-${post.id}">เพิ่มความคิดเห็น:</label>
        <input type="text" id="comment-${post.id}" name="comment" required/>
        <button type="submit">ส่ง</button>
    </form>
</div>
        </div>
          
    </c:forEach>
</c:if>

<!--<c:if test="${empty posts}">
    <p class="no-posts">ไม่พบโพสต์ที่ค้นหา</p>
</c:if>-->

<a class="logout-link" href="${pageContext.request.contextPath}/logout">ออกจากระบบ</a>

<script>
    function confirmDelete(postId) {
        var confirmDelete = confirm("คุณต้องการลบโพสต์นี้ใช่หรือไม่?");
        if (confirmDelete) {
            // กระทำการลบโพสต์ (สามารถเปลี่ยนไปยัง URL หรือการทำ AJAX request ได้)
            window.location.href = "${pageContext.request.contextPath}/delete/" + postId;
        }
    }
</script>
   
</body>
</html>
